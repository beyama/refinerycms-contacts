module NavigationHelpers
  module Refinery
    module Contacts
      def path_to(page_name)
        case page_name
        when /the contacts frontend list/
          contacts_path
        when /the contact frontend details of "?([^\"]*)"?/
          contact = Contact.find_by_last_name($1)
          contacts_path(contact)
        when /the contact detail of "?([^\"]*)"?/
          contact = Contact.find_by_last_name($1)
          admin_contact_path(contact)
        when /the list of contacts tagged with "?([^\"]*)"?/
          admin_contacts_path(:tag => $1)
        when /the list of contacts/
          admin_contacts_path
        when /the new contact form/
          new_admin_contact_path
        else
          nil
        end
      end
    end
  end
end
