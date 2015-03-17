class Report < ActiveRecord::Base
  belongs_to :host

  scope :my_reports, lambda { |*args|
    where(:reports => {:host_id => Host.search_for(args.first)})
  }
end
