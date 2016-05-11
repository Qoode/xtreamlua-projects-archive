-----------------------------------------------------------------------------
-- BLEX v 0.5 release candidate 1                                          --
-----------------------------------------------------------------------------
--
-- General lexer construction kit
--
-- copyright 2004 by Rici Lake. Permission is granted to use this code under
-- the same terms and conditions as found in the Lua copyright notice at
-- http://www.lua.org/license.html.
--
-- I'd appreciate a credit if you use this code, but I don't insist. 
--
-- ---------------------------------------------------------------
--
-- TODO:
--   Document exception system
--   Document freeze, restore
--
-- Note on Version 0.5
--
--   Previous versions of blex attempted to not read the entire source into
--   memory; this massively complicates the code and it is not clear to me
--   that it is necessary. So this one doesn't. If there is interest in
--   restoring this feature, please let me know.
--
--   Previous versions also came with example Lua lexers; that has now been
--   superseded by a separate Lua parser, which should be in the same distribution.
-- 
-- General Conventions: 
--
--   All member functions are called with "." syntax, not ":" syntax.
--   Each Lexer object is a distinct table with no metatable.
--   
--   Setter functions all return the object, allowing for setter chaining.
--   (eg: lex.setname("foo").setline(42) )
--   
-- Character positions
--   
--   The lexer maintains an internal line buffer and two pointers, start
--   and cursor. At the beginning of a lex operation, both start and cursor
--   are set to the current character position; cursor is then successively
--   moved to the right. All character positions are specified relative to
--   these pointers: the position 1 corresponds to start, and -1 corresponds
--   to cursor. The buffer itself is purely internal, but substrings can be
--   extracted with the token() accessor. Accessing positions outside the
--   range [start, cursor] has undefined behaviour except that if the adjusted
--   end is less than the adjusted beginning, an empty string will be returned.
--
--   In all the following APIs, s defaults to 1 and e defaults to -1.
--
-- Line numbers
--
--   The lexer tries to keep track of line numbers independently of pattern
--   matching. (It does this lazily.) You can set the apparent line number
--   with setline(); this sets the line number for the first character of
--   the line which includes start. (If start is a line end, this will be
--   the beginning of the line which ends at start.) If you are implementing
--   a #line sort of command, remember to subtract one.
--
-- Constructor:
--
--   The package defines a single constructor function
-- 
--   lexer =           Lexer (string, name, line)
--       string -- the string to lex
--       name   -- (a string) default is ""
--       line   -- (a number) default is 1
--   
-- State manipulation:
--   str =             name ()
--       returns name
--   self =            setname (name, [lno])
--       sets name, and optionally sets line number (default is to
--       not change line number, see also setline())
--   str =             token ([s], [e])
--       returns a substring of the current token, or a part of it.
--   int =             tokenlength ()
--       returns the length of the current token.
--   self =            settoken ([s], [e])
--       moves start and cursor. Moving cursor will affect the next match.
--       This can only be used to move cursor backwards (i.e. rescan) and
--       only within the current token, except that settoken(1, 0) will
--       cause the current token to be rescanned.
--   str =             line_to ([s])
--       Returns the line up to position s. This is intended to be used in
--       error messages and should not be abused.
--   int =             line ([s])
--       returns the line number at s.
--   self =            setline (lno, [s])
--       sets the line number for the line which includes position s to lno.
--       Note: once you have set the line number or requested the line number
--       for a particular position, trying to access line number information
--       for previous positions has undefined results. This restriction may
--       be lifted in a future version if there is popular demand.
--   fn =              errfn ()
--       returns the default error function. This interface is likely to disappear.
--   self =            seterrfn(fn)
--       sets the default error function. This interface is likely to disappear.
--       
-- Lexing:
--   ... =             lex (pattable, errfn)
--       Starts a new token, using pattable; returns the result of the
--       associated pattern function. See below for a discussion of
--       pattern tables. The default error function is the one set by
--       seterrfn; the default default is a function which throws an
--       error.
--   ... =             extend (pattable, errfn)
--       Like lex, but does not move the start pointer. Return values are
--       the same. The default errfn always returns nil and does not move
--       the cursor.
--   bool, s, cap... = match (pattern)
--       Matches 'pattern' against the current line starting at the cursor
--       On success, returns true, the start the match (in token coordinates),
--       and all captures. On failure, returns false.
--       cursor is updated to the end of the end of the match
--   bool, s, cap =    match1 (pattern)
--       like match but only returns one capture. This is much faster if you 
--       only have one capture (or none)
--   for ttype, token = tokens(patterns, errfn) do
--       returns an iterator which returns successive returns from lex
--   for ttype, token = extends(patterns, errfn) do
--       returns an iterator which returns successive returns from extend
--    
-- Pattern Tables:
--   A pattern table maps (Lua) patterns to functions.
--       
--   Each pattern should be anchored and have at most one capture.
--   The associated function will be called if the pattern is
--   selected; its return value will be the result of calling lex or extend.
--
--   The function will be called with two arguments: (lexobject, capture)
--   as arguments.
--       
--   If no token matches, the failure function specified as the second
--   argument to tokens will be called with a single argument, which is
--   the lexobject. Make sure you advance the cursor in this function,
--   or you will risk an endless loop. A good way to do this is:
--       
--     if self.match1"." then return "ERROR", self.token() end
--
--   If the start point is past the last character of the buffer, nil
--   will be returned.
--       
-----------------------------------------------------------------------------

return function(buf, name, line)

  ---------------------------------------------------------------------------
  -- Initialisation                                                        --
  ---------------------------------------------------------------------------
  local prev, cursor, self, linestart, buflen
      = 0,    0,      {},   1,         string.len(buf)
  line, name = line or 1, name or ""
  local catching = false
  
  local function alwaysNil() end
  
  function self.freeze()
    return {buf=buf, name=name, line=line, prev=prev, cursor=cursor,
            linestart=linestart, catching=catching}
  end
  
  function self.restore(t)
    buf, name, line, prev, cursor, linestart, catching =
       t.buf, t.name, t.line, t.prev, t.cursor, t.linestart, t.catching
    buflen = string.len(buf)
  end

  local function adjusts(idx)
    if not idx then return prev end
    if idx >= 0 then
      idx = prev + idx - 1
      if idx > cursor then idx = cursor + 1 end
     else
      idx = cursor + idx + 1
      if idx < prev then idx = prev end
    end
    return idx
  end
  
  local function adjuste(idx)
    if not idx then return cursor end
    if idx >= 0 then
      idx = prev + idx - 1
      if idx > cursor then idx = cursor end
     else
      idx = cursor + idx + 1
      if idx < prev then idx = prev - 1 end
    end
    return idx
  end
  
  local function update_linestart(pos)
    local s = linestart
    while true do
      local news = string.find(buf, "\n", s, true) or pos
      if news >= pos then break end
      s, line = news + 1, line + 1
    end
    linestart = s
  end
  
  ---------------------------------------------------------------------------
  -- Simple exception system                                               --
  ---------------------------------------------------------------------------
  
  function self.throw(fmt, ...)
    local errmsg = string.format("%s at line %i of '%s'",
                                  string.format(fmt, unpack(arg)),
                                  self.line(-1), name)
    if catching then
      self.errmsg = errmsg
      error(self)
     else
      error(errmsg)
    end
  end
  
  function self.protected_parse(parse)
    catching = true
    local rv, flag = xpcall(function() return parse(self) end, debug.traceback)
    catching = false
    if flag then return flag, rv
     elseif rv == self then return nil, self.errmsg
     else error(rv)
    end
  end
  
  -- Default error function
  local function errfn(self, rtoken)
    local _, ch = self.match1("^(.)")
    if string.find(ch, "%c") then
      ch = string.format("\\x%02x", string.byte(ch))
    end
    self.throw("Unrecognised symbol '%s'", ch)
  end
  
  ---------------------------------------------------------------------------
  -- Getter methods                                                        --
  ---------------------------------------------------------------------------
  function self.line(s)
    update_linestart(adjusts(s))
    return line
  end
    
  function self.name() return name end
  
  function self.token(s, e)
    return string.sub(buf, adjusts(s), adjuste(e))
  end
 
  function self.tokenlength() return cursor - prev + 1 end

  function self.line_to(s)
    s = adjusts(s)
    update_linestart(s)
    return string.sub(buf, linestart, s)
  end

  function self.errfn() return errfn end
  
  ---------------------------------------------------------------------------
  -- Setter methods                                                        --
  ---------------------------------------------------------------------------
  function self.setline(lno, s)
    update_linestart(adjusts(s))
    line = lno
    return self
  end
  
  function self.setname(n, lno)
    name = n
    if lno then
      update_linestart(prev)
      line = lno
    end
    return self
  end

  function self.settoken(s, e)
    prev, cursor = adjusts(s), adjuste(e)
    return self
  end
  
  function self.seterrfn(fn)
    errfn = fn
    return self
  end
  
  ---------------------------------------------------------------------------
  -- Matching                                                              --
  ---------------------------------------------------------------------------
  local function blex(patterns, rcompleter, st)
    local emax, rcapture = cursor
    if st <= buflen then
      for pat, completer in patterns do
        local s, e, capture = string.find(buf, pat, st)
        -- possibly should be <=. < rejects empty matches.
        if e and emax < e then
          emax, rcompleter, rcapture = e, completer, capture
        end
      end
      cursor = emax
      return rcompleter(self, rcapture)
    end
  end
  
  function self.extend(patterns, efn)
    return blex(patterns, efn or alwaysNil, cursor + 1)
  end

  function self.lex(patterns, efn)
    prev = cursor + 1
    return blex(patterns, efn or errfn, prev)
  end

  function self.match1(pat)
    local s, e, token = string.find(buf, pat, cursor + 1)
    cursor = e or cursor
    return e, token
  end
  
  function self.match(pat)
    local v = {string.find(buf, pat, cursor + 1)}
    if v[1] then
      cursor, v[1], v[2] = v[2], true, v[1]
      return unpack(v)
    end
  end
  
  ---------------------------------------------------------------------------
  -- Iterator generators                                                    --
  ---------------------------------------------------------------------------
  function self.tokens(patterns, efn)
    efn = efn or errfn
    local function lexer(patterns)
      prev = cursor + 1
      return blex(patterns, efn, prev)
    end
    return lexer, patterns
  end

  function self.extends(patterns, efn)
    efn = efn or alwaysNil
    local function extender(patterns)
      return blex(patterns, efn, cursor + 1)
    end
    return extender, patterns
  end
   
  return self
end