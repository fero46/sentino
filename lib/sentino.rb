$LOAD_PATH.unshift(File.dirname(__FILE__))

module Sentino
  autoload :Word, 'sentino/word'
  autoload :Pattern, 'sentino/pattern'
end
