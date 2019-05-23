class Pokemon
    attr_accessor :id, :name, :type, :hp, :db

    def initialize(id:, name:, type:, hp: nil, db:)
        @id = id
        @name = name
        @type = type
        @hp = hp
        @db = db
    end        

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1;
        SQL

        pokemon_data = db.execute(sql, id).flatten

        Pokemon.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], hp: pokemon_data[3], db: db)
    end

    def alter_hp(new_hp, db)
        sql =<<-SQL
            UPDATE pokemon
            SET hp = ?
            WHERE id = ?;
        SQL

        db.execute(sql, new_hp, self.id)
    end

end
