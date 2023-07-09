resource "aws_dynamodb_table" "my-game-table" {
    name  = "my-game-table"
    billing_mode = "PROVISIONED"
    read_capacity = 20
    write_capacity = 20
    hash_key = "GameTitle"
    attribute {
        name = "GameTitle"
        type = "S"
    }
    attribute {
        name = "Year"
        type = "N"
    }

    global_secondary_index {
        name = "GameTitleIndex"
        hash_key = "Year"
        write_capacity = 20
        read_capacity = 20
        projection_type = "INCLUDE"
        non_key_attributes = ["Company", "Genre"]
    }
}

