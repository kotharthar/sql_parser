require "rubygems"
require "treetop"

dir = File.expand_path(File.dirname(__FILE__))
Treetop.load File.expand_path("#{dir}/sql_parser/sql_parser")

class SqlParser::ItemsNode < Treetop::Runtime::SyntaxNode
  def values
    items.values.unshift(item.value)
  end
end

class SqlParser::InListItemsNode < Treetop::Runtime::SyntaxNode
  def values
    inlist_items.values.unshift(inlist_item.value)
  end
end

class SqlParser::ItemNode < Treetop::Runtime::SyntaxNode
  def values
    [value]
  end
  
  def value
    text_value.to_sym
  end
end

class SqlParser::InListStringItemNode < Treetop::Runtime::SyntaxNode
  def values
    [value]
  end
  
  def value
    text_value[1..-2]
  end
end

class SqlParser::InListNumberItemNode < Treetop::Runtime::SyntaxNode
  def values
    [value]
  end
  
  def value
    Integer(text_value)
  end
end
