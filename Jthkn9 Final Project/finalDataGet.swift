import Foundation

struct jsonReadFile {
    let json: Data
    
    init() {
        json = jsonString.data(using: .utf8)!
    }
    
    private let jsonString: String = """
[
    
       {
           "id": 8D31B96A-02AC-4531-976F-A455686F8FE2,
           "logo": "RGCV",
           "teamName": "RGCV",
           "roster": [
               {
                   
                   "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE2,
                   "name": "Zach Gunn",
                   "seasons": [
                       {
                           "year": 2019,
                           "atBat": 97,
                           "hits": 55,
                           "walks": 35,
                           "homeRuns": 23,
                           "rBIS": 63,
                           "runs": 41
                       }
                   ]
                                 
               },
               {
                   
                   "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE2,
                   "name": "David Noel",
                   "seasons": [
                       {
                        "year": 2019,
                        "atBat": 79,
                        "hits": 32,
                        "walks": 14,
                        "homeRuns": 9,
                        "rBIS": 26,
                        "runs": 26
                       }
                   ]
               },
               {
                   
                   "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE2,
                   "name": "Thomas Citrowske",
                   "seasons": [
                       {
                        "year": 2019,
                        "atBat": 21,
                        "hits": 2,
                        "walks": 10,
                        "homeRuns": 0,
                        "rBIS": 2,
                        "runs": 3
                       }
                   ]
               },
               {
                   
                   "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE2,
                   "name": "John Paul",
                   "seasons": [
                       {
                        "year": 2019,
                        "atBat": 93,
                        "hits": 18,
                        "walks": 30,
                        "homeRuns": 2,
                        "rBIS": 17,
                        "runs": 24
                       }
                   ]
               },
               {
                   
                   "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE2,
                   "name": "Olivia Baalman",
                   "seasons": [
                       {
                        "year": 2019,
                        "atBat": 90,
                        "hits": 23,
                        "walks": 19,
                        "homeRuns": 2,
                        "rBIS": 10,
                        "runs": 21
                       }
                   ]
               }
           ],
           "schedule": [
            {
                "year": "2019",
                "games": [
                    
                ]
            }
         
       ],
           "wins": 27,
           "losses": 9
       },
       {
        "id": 4,
        "logo": "SpecialK",
        "teamName": "The Special K's",
        "roster": [
            {
                
                "teamId": 4,
                "name": "Hunter Tabor",
                "seasons": [
                    {
                        "year": 2019,
                        "atBat": 24,
                        "hits": 8,
                        "walks": 4,
                        "homeRuns": 1,
                        "rBIS": 7,
                        "runs": 4
                    }
                ]
                              
            },
            {
                
                "teamId": 4,
                "name": "Paul Noel",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 73,
                     "hits": 21,
                     "walks": 19,
                     "homeRuns": 7,
                     "rBIS": 20,
                     "runs": 18
                    }
                ]
            },
            {
                
                "teamId": 4,
                "name": "Charlie Schark",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 27,
                     "hits": 11,
                     "walks": 7,
                     "homeRuns": 4,
                     "rBIS": 14,
                     "runs": 10
                    }
                ]
            },
            {
                
                "teamId": 4,
                "name": "Michael Daub",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 87,
                     "hits": 24,
                     "walks": 15,
                     "homeRuns": 14,
                     "rBIS": 20,
                     "runs": 22
                    }
                ]
            },
            {
               
                "teamId": 4,
                "name": "James Daub",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 105,
                     "hits": 25,
                     "walks": 8,
                     "homeRuns": 10,
                     "rBIS": 20,
                     "runs": 21
                    }
                ]
            },
            {
                 
                 "teamId": 4,
                 "name": "Ethan Hunte",
                 "seasons": [
                     {
                         "year": 2019,
                         "atBat": 56,
                         "hits": 11,
                         "walks": 6,
                         "homeRuns": 0,
                         "rBIS": 4,
                         "runs": 3
                     }
                 ]
             }
        ],
        "schedule": [
         {
             "year": "2019",
             "games": [
                 
             ]
         }
      
    ],
        "wins": 17,
        "losses": 19
    },
    {
        "id": 5,
        "logo": "Dino",
        "teamName": "The Dinosaurs",
        "roster": [
            {
                
                "teamId": 5,
                "name": "Jack Schark",
                "seasons": [
                    {
                        "year": 2019,
                        "atBat": 55,
                        "hits": 21,
                        "walks": 13,
                        "homeRuns": 4,
                        "rBIS": 13,
                        "runs": 17
                    }
                ]
                              
            },
            {
                
                "teamId": 5,
                "name": "Logan Bond",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 70,
                     "hits": 28,
                     "walks": 8,
                     "homeRuns": 2,
                     "rBIS": 13,
                     "runs": 13
                    }
                ]
            },
            {
                
                "teamId": 5,
                "name": "Cece Mueller",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 73,
                     "hits": 24,
                     "walks": 15,
                     "homeRuns": 0,
                     "rBIS": 9,
                     "runs": 13
                    }
                ]
            },
            {
                
                "teamId": 5,
                "name": "Brendan Summers",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 50,
                     "hits": 10,
                     "walks": 20,
                     "homeRuns": 3,
                     "rBIS": 13,
                     "runs": 12
                    }
                ]
            },
            {
                
                "teamId": 5,
                "name": "John Noel",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 80,
                     "hits": 25,
                     "walks": 20,
                     "homeRuns": 7,
                     "rBIS": 23,
                     "runs": 18
                    }
                ]
            },
            {
                 
                 "teamId": 5,
                 "name": "Isaac Noel",
                 "seasons": [
                     {
                         "year": 2019,
                         "atBat": 65,
                         "hits": 19,
                         "walks": 24,
                         "homeRuns": 4,
                         "rBIS": 20,
                         "runs": 18
                     }
                 ]
             }
        ],
        "schedule": [
         {
             "year": "2019",
             "games": [
                 
             ]
         }
      
    ],
        "wins": 14,
        "losses": 22
    },
       {
        "id": 1,
        "logo": "NoobNugs",
        "teamName": "Noob Nuggets",
        "roster": [
            {
                
                "teamId": 1,
                "name": "John Citrowske",
                "seasons": [
                    {
                        "year": 2019,
                        "atBat": 46,
                        "hits": 17,
                        "walks": 22,
                        "homeRuns": 4,
                        "rBIS": 23,
                        "runs": 21
                    }
                ]
                              
            },
            {
                
                "teamId": 1,
                "name": "John Daub",
                "seasons": [
                    {
                        "year": 2019,
                        "atBat": 80,
                        "hits": 38,
                        "walks": 20,
                        "homeRuns": 1,
                        "rBIS": 14,
                        "runs": 18
                    }
                ]
            },
            {
                
                "teamId": 1,
                "name": "Jack Hoenig",
                "seasons": [
                    {
                        "year": 2019,
                        "atBat": 5,
                        "hits": 0,
                        "walks": 9,
                        "homeRuns": 0,
                        "rBIS": 2,
                        "runs": 2
                    }
                ]
            },
            {
                
                "teamId": 1,
                "name": "Eathan Gunn",
                "seasons": [
                    {
                     "year": 2019,
                     "atBat": 76,
                     "hits": 24,
                     "walks": 33,
                     "homeRuns": 8,
                     "rBIS": 38,
                     "runs": 26
                    }
                ]
            },
            {
               
                "teamId": 1,
                "name": "Josh Noel",
                "seasons": [
                    {
                         "year": 2019,
                         "atBat": 24,
                         "hits": 7,
                         "walks": 5,
                         "homeRuns": 2,
                         "rBIS": 8,
                         "runs": 4
                    }
                ]
            },
            {
                 
                 "teamId": 1,
                 "name": "Will Hoenig",
                 "seasons": [
                     {
                         "year": 2019,
                         "atBat": 57,
                         "hits": 6,
                         "walks": 28,
                         "homeRuns": 2,
                         "rBIS": 13,
                         "runs": 18
                     }
                 ]
             }
        ],
        "schedule": [
         {
             "year": "2019",
             "games": [
                 {
                 "date": "7/24/2019",
                 "opponentId": 2,
                 "gameWon": true
                 },
                 {
                 "date": "7/24/2019",
                 "opponentId": 2,
                 "gameWon": false
                 },
                 {
                 "date": "7/24/2019",
                 "opponentId": 2,
                 "gameWon": true
                 }
             ]
         }
      
    ],
        "wins": 15,
        "losses": 21
    },

       {
           "id": 8D31B96A-02AC-4531-976F-A455686F8FE3,
           "logo": "Commitee",
           "teamName": "The Commitee",
           "roster": [
              
                {
                
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Patrick Baalman",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 94,
                            "hits": 44,
                            "walks": 26,
                            "homeRuns": 12,
                            "rBIS": 37,
                            "runs": 28
                        }
                    ]
                },
                {
                    
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Drew Baalman",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 70,
                            "hits": 17,
                            "walks": 34,
                            "homeRuns": 0,
                            "rBIS": 10,
                            "runs": 22
                        }
                    ]
                },
                {
                   
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Paul Battis",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 41,
                            "hits": 12,
                            "walks": 12,
                            "homeRuns": 2,
                            "rBIS": 5,
                            "runs": 10
                        }
                    ]
                },
                {
                    
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Zach Clever",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 101,
                            "hits": 27,
                            "walks": 10,
                            "homeRuns": 5,
                            "rBIS": 26,
                            "runs": 29
                        }
                    ]
                },
                {
                    
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Nick Rackers",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 90,
                            "hits": 16,
                            "walks": 21,
                            "homeRuns": 2,
                            "rBIS": 8,
                            "runs": 11
                        }
                    ]
                },
                {
                    "teamId": 8D31B96A-02AC-4531-976F-A455686F8FE3,
                    "name": "Dominic Citrowske",
                    "seasons": [
                        {
                            "year": 2019,
                            "atBat": 81,
                            "hits": 14,
                            "walks": 20,
                            "homeRuns": 2,
                            "rBIS": 6,
                            "runs": 9
                        }
                    ]
                }
              
           ],
           "schedule": [
                {
                    "year": "2019",
                    "games": [
                       
                    ]
                }
             
           ],
           "wins": 25,
           "losses": 11
       }
   
]

"""
}

//let decoder = JSONDecoder()
//let teams = try decoder.decode(Teams.self, from: json2)
//for team in teams.teams {
//  print(team.teamName)
//  print("Has this roster:")
//  for player in team.roster{
//    print("\t\(player.name)")
//    print("\t 2019 season stats:")
//    for stat in player.seasons.filter({$0.year == 2019}) {
//      print("\t\t runs: \(stat.runs)")
//      print("\t\t homeRuns: \(stat.homeRuns)")
//      print("\t\t RBI: \(stat.rBIS)")
//    }
//    print("\t 2020 season stats:")
//      for stat in player.seasons.filter({$0.year == 2020}) {
//      print("\t\t runs: \(stat.runs)")
//      print("\t\t homeRuns: \(stat.homeRuns)")
//      print("\t\t RBI: \(stat.rBIS)")
//    }
//  }
//  print()
//}
//print(product.id) // Prints "Durian"




