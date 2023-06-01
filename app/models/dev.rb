class Dev < ActiveRecord::Base
    has_many :freebies
    has_many :companies, through: :freebies

    def freebies
        Freebie.all.where(dev_id: self.id)
    end

    def companies
        x = []
        (self.freebies.map {|f| f[:company_id]}.uniq).each{|dev|
            x << Company.find(dev)
        }
        x
    end

    # Dev#received_one?(item_name)
    # accepts an item_name (string) and returns true if any of the 
    # freebies associated with the dev has that item_name, otherwise returns false
    def received_one?(item_name)
        x = Freebie.find_by(item_name: item_name)
        if (x==nil)
            return false
        elsif (x[:dev_id]!=self.id)
            return false           
        else
            return true            
        end
    end
    
    
    # Dev#give_away(dev, freebie)
    # accepts a Dev instance and a Freebie instance, changes the 
    # freebie's
    # dev to be the given dev; your code should only make the change 
    # if the freebie belongs to the dev who's giving it away
    def give_away(dev, freebie)
        if (freebie[:dev_id]!=self[:id])
            return "It seems the item isn't yours!"
        else
            freebie[:dev_id] = dev[:id]
            freebie.save
            return "You've given away the item."
        end
    end
end
