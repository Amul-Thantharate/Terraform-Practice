

resource "aws_dynamodb_table_item" "item_2" {
    table_name = aws_dynamodb_table.my-game-table.name
    hash_key = aws_dynamodb_table.my-game-table.hash_key
    for_each = {
        "Max Payne 3" = {
            "Year" = "2012",
            "Company" = "Rockstar Games",
            "Genre" = "Third-person shooter"
        }
        "Just Cause 4" = {
            "Year" = "2015",
            "Company" = "Square Enix",
            "Genre" = "Action-adventure"
        }
        "Ghost of Tsushima" = {
            "Year" = "2020",
            "Company" = "Sony Interactive Entertainment",
            "Genre" = "Action-adventure"
        }
        "The Last of Us Part II" = {
            "Year" = "2020",
            "Company" = "Sony Interactive Entertainment",
            "Genre" = "Action-adventure"
        }
        "Death Stranding" = {
            "Year" = "2019",
            "Company" = "Sony Interactive Entertainment",
            "Genre" = "Action-adventure"
        }
        "God of war" = {
            "Year" = "2018",
            "Company" = "Sony Interactive Entertainment",
            "Genre" = "Action-adventure"
        }
        "BioShock Infinite" = {
            "Year" = "2013",
            "Company" = "2K Games",
            "Genre" = "First-person shooter"
        }
        "The Elder Scrolls V: Skyrim" = {
            "Year" = "2011",
            "Company" = "Bethesda Softworks",
            "Genre" = "Action role-playing"
        }
        "Biomutant" = {
            "Year" = "2021",
            "Company" = "THQ Nordic",
            "Genre" = "Action role-playing"
        }
        "Cyberpunk 2077" = {
            "Year" = "2020",
            "Company" = "CD Projekt",
            "Genre" = "Action role-playing"
        }
    }
    item =  <<ITEM
{
    "GameTitle": {"S": "${each.key}"},
    "Year": {"N": "${each.value.Year}"},
    "Company": {"S": "${each.value.Company}"},
    "Genre": {"S": "${each.value.Genre}"}
    }

ITEM

}