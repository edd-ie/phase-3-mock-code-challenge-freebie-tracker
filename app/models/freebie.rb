class Freebie < ActiveRecord::Base
    belongs_to :companies
    belongs_to :devs

    def dev
        Dev.find(self.dev_id)
    end

    def company
        Company.find(self.company_id)
    end

    def print_details
        "#{self.dev[:name]} owns a #{self[:item_name]} from #{self.company[:name]}"
    end

end
