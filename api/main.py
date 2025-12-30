from flask import Flask
from api.routes import routes
from flasgger import Swagger

app = Flask(__name__)
swagger = Swagger(app)

app.register_blueprint(routes)
if __name__ == "__main__":
  #  up_database.create_database()
    app.run(host="0.0.0.0", port=5001, debug=True)
    