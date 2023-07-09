resource "aws_dynamodb_table_item" "game_table_item_1" {
    table_name = aws_dynamodb_table.my-game-table.name
    hash_key = aws_dynamodb_table.my-game-table.hash_key  
    for_each = {
        "Grand Theft Auto V" = {
            "Year" = "2013",
            "Company" = "Rockstar Games",
            "Genre" = "Action-adventure"
        }
        "Call of Duty: Modern Warfare" = {
            "Year" = "2019",
            "Company" = "Activision",
            "Genre" = "First-person shooter"
        }
        "Minecraft" = {
            "Year" = "2011",
            "Company" = "Mojang Studios",
            "Genre" = "Sandbox"
        }
        "Red Dead Redemption 2" = {
            "Year" = "2018",
            "Company" = "Rockstar Games",
            "Genre" = "Action-adventure"
        }
        "Battelfield 2042" = {
            "Year" = "2016",
            "Company" = "Electronic Arts",
            "Genre" = "First-person shooter"
        }
        "The Witcher 3: Wild Hunt" = {
            "Year" = "2015",
            "Company" = "CD Projekt",
            "Genre" = "Action role-playing"
        }
        "Hogwarts Legacy" = {
            "Year" = "2022",
            "Company" = "Warner Bros. Interactive Entertainment",
            "Genre" = "Action role-playing"
        }
        "Watch Dogs: Legion" = {
            "Year" = "2020",
            "Company" = "Ubisoft",
            "Genre" = "Action-adventure"
        }
        "WW2K22" = {
            "Year" = "2021",
            "Company" = "2K Sports",
            "Genre" = "Sports"
        }
        "FIFA 22" = {
            "Year" = "2021",
            "Company" = "Electronic Arts",
            "Genre" = "Sports"
        }
        "NBA 2K22" = {
            "Year" = "2021",
            "Company" = "2K Sports",
            "Genre" = "Sports"
        }
        "Far Cry 6" = {
            "Year" = "2021",
            "Company" = "Ubisoft",
            "Genre" = "Action-adventure"
        }
        "Forza Horizon 5" = {
            "Year" = "2021",
            "Company" = "Microsoft Studios",
            "Genre" = "Racing"
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



