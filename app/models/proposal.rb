require "addressable/uri"

class LinkValidator < ActiveModel::Validator
  def validate(record)
    unless record.link.blank?
      url = record.link
      url = "https://#{url}" unless url.start_with?('http')
      uri = Addressable::URI.parse(url)
      unless Rails.configuration.x.allowed_link_domains.include? uri.domain
        record.errors[:link] << 'domain not in allowed domains'
      else
        record.link = "http://#{uri.host}#{uri.path}"
      end
    else
      record.errors[:link] << "can't be black"
    end
  end
end

class Proposal < ApplicationRecord
  validates :name, presence: true
  validates_with LinkValidator
  validates :bio, length: { maximum: 1000 }
end
