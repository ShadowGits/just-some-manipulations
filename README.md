# just_some_manipulations
A flutter app to create wordlcloud of user input text. 
Currently a horse shaped mask is used as a default shape for wordcloud.

## Frontend and UI Interactions
- Dart and Flutter<br/>
    :http post methods used to fetch data<br/>
    :Image encoded in base 64 string used to write bytes to a file and the load the image generated.<br/>
    :Custom icon radio button made for UI furnishing.<br/>
## Backend Interactioons
- Python Flask, REST API<br/>
    :Text to masked wordcloud implemented in backend through python<br/>
    :Image generated is encoded to base64 string and sent in json format<br/>
    :http post used to fetch text from UI and create cloud.<br/>
