class Host < ActiveRecord::Base
  belongs_to :hostgroup

  scoped_search :in => :hostgroup,   :on => :name,    :complete_value => true,  :rename => :hostgroup
  scoped_search :in => :hostgroup,   :on => :id,      :complete_enabled => false, :rename => :hostgroup_id, :only_explicit => true
end
