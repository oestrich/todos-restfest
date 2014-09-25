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
        "name" =>  "todo",
        "href" =>  "http://todo.smartlogic.io/relations/{rel}",
        "templated" => true
      }]
    }
  end
end
