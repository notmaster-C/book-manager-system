from flask import Flask, request, jsonify
from flask_cors import CORS
from gpt_index import SimpleDirectoryReader, GPTSimpleVectorIndex, LLMPredictor, PromptHelper, ServiceContext
from langchain import OpenAI
import os

app = Flask(__name__)
CORS(app, supports_credentials=True)

os.system('python dbreader.py')
os.environ["OPENAI_API_KEY"] = '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'

def createVectorIndex(path):
    max_input = 4096
    tokens = 1000
    chunk_size = 600
    max_chunk_overlap = 20

    promptHelper = PromptHelper(max_input, tokens, chunk_size, max_chunk_overlap, chunk_size_limit=chunk_size)
    documents = SimpleDirectoryReader(path).load_data()
    service_context = ServiceContext.from_defaults(prompt_helper=promptHelper)
    llmPredictor = LLMPredictor(llm=OpenAI(temperature=0, model_name="text-davinci-003", max_tokens=tokens))
    service_context.llmPredictor = llmPredictor
    vectorIndex = GPTSimpleVectorIndex.from_documents(documents=documents, service_context=service_context)
    vectorIndex.save_to_disk('vectorIndex.json')
    return vectorIndex

vectorIndex = createVectorIndex('dbinfo')

@app.route('/', methods=["GET", "POST"])
def result():
    ppt = request.get_json()
    userinput = ppt['userinput']
    vIndex = GPTSimpleVectorIndex.load_from_disk('vectorIndex.json')
    response = vIndex.query(userinput, response_mode="compact")
    result = {}
    result['response'] = response

    return result

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=2000)