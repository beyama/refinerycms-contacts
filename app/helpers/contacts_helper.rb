module ContactsHelper
  
  def contact_link_to(link, options = nil, escape = true, &block)
    options ||= {}
    options[:href] = link =~ /^https?:\/\// ? link : "http://#{link}" 
    content_tag(:a, link, options, escape, &block)
  end
  
end