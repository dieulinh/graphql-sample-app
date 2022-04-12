class AddIpAddressToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :ip_address, :string
  end
end
