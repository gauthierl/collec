//variable pour pouvoir trouver à quel champ on ajoute les données
var idChamp;

function setChoiceList(file){
     confirmed = true;
    if(file.length > 50){
        confirmed = confirm("Ce fichier contient plus de 50 entrées. Etes-vous sûr de vouloir l'importer ?");
    }
    if (confirmed){
        var numChild;
        //on retrouve le bon champ pour importer les données
        for(var i=0; i< $("#metadata").alpaca()["children"].length; i++){
            if ($("#metadata").alpaca()["children"][i]["id"]==idChamp){
                numChild=i;
            }
        }
        value = $("#metadata").alpaca().getValue();
        value[numChild]["choiceList"]=file;
        $("#metadata").alpaca("destroy");
        renderForm(value);
    }
    else{

    }
}


function renderForm(data){
        $("#metadata").alpaca({
            "data": data,
            "schema": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "nom": {
                            "title": "Nom du champ",
                            "type": "string",
                            "required": true
                        },
                        "type": {
                            "title": "Type du champ",
                            "type": "string",
                            "required": true,
                            "enum": ["number","string","textarea","date","checkbox","select"],
                            "default": "string"
                        },
                         "importFile":{
                            "type" : "string",
                            "format": "uri"
                        },
                        "choiceList": {
                            "title": "Choix possibles",
                            "type": "array",
                            "items": {
                                "type": "string"
                            }
                        },
                        "require": {
                        },
                        "helperChoice": {
                        },
                        "helper" :{
                            "type": "string",
                            "title": "Message d'aide"
                        },
                        "description" :{
                            "title": "Description du champ",
                            "type" : "string",
                            "required": true
                        },
                        "meusureUnit" :{
                            "title": "Unité de mesure (ou modalités)",
                            "type" : "string",
                            "required": true
                        }
                    },
                    "dependencies": {
                        "importFile":["type"],
                        "choiceList": ["type"],
                        "helper": ["helperChoice"]
                    }
                }
            },
            "options": {
                "items": {
                    "fields": {
                        "type": {
                            "optionLabels": ["Nombre","Texte (une ligne)","Texte (multi-ligne)","Date","Checkbox","Liste à choix multiple"],
                            "type": "select",
                            "hideNone": true,
                            "sort": function(a, b) { 
                                            return 0; 
                                        }
                        },
                        "typeList":{
                            "dependencies": {
                                "type":"Liste"
                            }
                        },
                        "importFile":{
                            "type": "file",
                            "label" : "Importer un fichier CSV",
                            "dependencies": {
                                "type":"select"
                            },
                            "selectionHandler": function(files,data){
                                $.get(data[0],function(responseText){
                                    file=responseText.split(",");
                                    setChoiceList(file);
                                });
                                idChamp = this["parent"]["id"];
                            }
                        },
                        "choiceList":{
                            "dependencies": {
                                "type":"select"
                            }
                        },
                        "require": {
                            "type": "checkbox",
                            "rightLabel": "Obligatoire"
                        },
                        "helperChoice": {
                            "type": "checkbox",
                            "rightLabel": "Message d'aide"
                        },
                        "helper": {
                            "helper": "Vous pouvez copier ici la description et l'unité de mesure",
                            "dependencies": {
                                "helperChoice": true
                            }
                        },
                        "description" :{
                            "type" : "textarea"
                        },
                        "meusureUnit" :{
                            "type" : "textarea"
                        }
                    }
                }
            },
            "postRender": function(control) {

                control.on("mouseout",function(){
                var value = control.getValue();
                var metadataField = document.getElementById("metadataField");
                metadataField.setAttribute("value",JSON.stringify(value, null,null));
                });

                control.on("change",function(){
                var value = control.getValue();
                var metadataField = document.getElementById("metadataField");
                metadataField.setAttribute("value",JSON.stringify(value, null,null));
                });

                var value = control.getValue();
                var metadataField = document.getElementById("metadataField");
                metadataField.setAttribute("value",JSON.stringify(value, null,null));
                
                
            }
            
        });
}

