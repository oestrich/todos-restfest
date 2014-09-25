module ApplicationSerializer
  def self.included(base)
    base.class_eval do
      root false

      attributes :_links
    end
  end

  def _links
    {
      "curies" =>  [{
        "name" =>  "todos",
        "href" =>  "http://todos.smartlogic.io/relations/{rel}",
        "templated" => true
      }],
    }
  end
end
