### service indisponible
GET http://localhost:5050/404

############################## LISTS #############################

### récupération de toutes les listes
GET http://localhost:5050/lists

### récupération d'une liste
GET http://localhost:5050/lists/2

### création d'une liste
POST http://localhost:5050/lists
Content-Type: application/json

{
    "name": "liste test post",
    "position": 1
}

### modification d'une liste
PATCH http://localhost:5050/lists/1
Content-Type: application/json

{
    "name": "liste test patch"
}

### suppression d'une liste
DELETE http://localhost:5050/lists/3

############################## CARDS #############################

### récupération de toutes les cartes d'une liste
GET http://localhost:5050/lists/9/cards

### récupération d'une carte
GET http://localhost:5050/cards/4

### création d'une carte
POST http://localhost:5050/cards
Content-Type: application/json

{
    "content": "carte test post",
    "color": "#f0f",
    "list_id": 1
}

### modification d'une carte
PATCH http://localhost:5050/cards/1
Content-Type: application/json

{
    "content": "carte test patch",
    "color": "#f0f",
    "position": 1
}

### suppression d'une carte
DELETE http://localhost:5050/cards/5

############################## TAGS #############################

### récupération de tous les tagss
GET http://localhost:5050/tags

### création d'un tag
POST http://localhost:5050/tags
Content-Type: application/json

{
    "name": "urgentissime",
    "color": "#f0f"
}

### modification d'un tags
PATCH http://localhost:5050/tags/1
Content-Type: application/json

{
    "name": "URGENT",
    "color": "#F0F"
}

### suppression d'un tags
DELETE http://localhost:5050/tags/2

### associer un tag à une carte
POST http://localhost:5050/cards/2/tags
Content-Type: application/json

{ "tagId": 1 }

### dissocié un tag d'une carte
DELETE http://localhost:5050/cards/2/tags/1