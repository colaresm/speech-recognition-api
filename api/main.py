from flask import Flask
from api.routes import routes
from database_layer import up_database
app = Flask(__name__)

app.register_blueprint(routes)

if __name__ == "__main__":
  #  up_database.create_database()
    app.run(host="0.0.0.0", port=5001, debug=True)
    