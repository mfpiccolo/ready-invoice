# == Schema Information
#
# Table name: sf_models
#
#  id            :integer          not null, primary key
#  salesforce_id :integer
#  model_name    :string(255)
#  records       :json
#  created_at    :datetime
#  updated_at    :datetime
#

class SfModel < ActiveRecord::Base
  belongs_to :salesforce

  after_initialize :setup_model

  def all
    records[model_name].map { |record| JsonToAR.new(record, model_name) }
  end

  def find( param )
    all.detect { |i| i.Id == param } || raise(ActiveRecord::RecordNotFound)
  end

  def where( query )
    ret = []
    all.each { |i| ret.push(i) if i.include?(query) } ||
        raise(ActiveRecord::RecordNotFound)
    return ret
  end


  private

  def setup_model
    PG.const_set(model_name, self)
  end
end
