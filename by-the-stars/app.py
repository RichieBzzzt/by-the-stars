from flask import Flask, request, Response
import json
from delete_resource_group import delete_pr_resource_group

app = Flask(__name__)


@app.route("/webhook", methods=["POST"])
def respond():
    request_json = request.json
    print(request_json)
    delete_pr_resource_group()
    return Response(status=200)
