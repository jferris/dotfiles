function! ERubyIterVar(collection)
  " remove leading space
  let collection = substitute(a:collection,"^\\s\\+","","")
  " remove chains like post.users
  let collection = substitute(collection,"^.*\\.","","")
  " remove instance variable punctuation
  let collection = substitute(collection,"^@","","")
  " singularize
  return rails#singularize(collection)
endfunction

function! PrefixWithKeyArgument(text)
  return ToTranslateKey(a:text) . '", :default => "' . a:text
endfunction
