class Company < ActiveRecord::Base
    has_many :freebies
    has_many :devs, through: :freebies

    def freebies
        Freebie.all.where(company_id: self.id)
    end

    def devs
        x = []
        (self.freebies.map {|f| f[:dev_id]}.uniq).each{|dev|
            x << Dev.find(dev)
        }
        x
    end

    def give_freebie(dev, item_name, value)
        f = Freebie.create(item_name: item_name, value: value, dev_id: dev[:id], company_id: self.id)
        f.print_details
    end
    def self.oldest_company
        Company.find_by(founding_year: Company.minimum(:founding_year))
    end
end
