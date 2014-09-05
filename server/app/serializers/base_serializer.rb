class BaseSerializer < ActiveModel::Serializer
  def root
    false
  end

  def as_json_with_wrap(options={})
    {
      :links => links,
      :data => as_json_without_wrap
    }
  end

  def links
    {}
  end

  alias_method_chain :as_json, :wrap
end
