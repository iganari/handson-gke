/**
 * Triggered from a message on a Cloud Pub/Sub topic.
 *
 * @param {!Object} event Event payload.
 * @param {!Object} context Metadata for the event.
 */
var googleapis = require("googleapis");
var request = require("request");
var APIURL = "https://cloudbuild.googleapis.com/v1/projects/avex-adg-webformbackend-dev/triggers/5f819b55-172a-4776-a731-afb36c5c5eda:run"
exports.helloPubSub = (event, context) => {
  const message = event.data
    ? Buffer.from(event.data, 'base64').toString()
    : 'update start';
  console.log(message);
    async function main() {
    const token = await googleapis.google.auth.getAccessToken();
    console.log(token);
    var options = {
      url: APIURL,
      method: 'POST',
      headers: {
        Authorization: ' Bearer ' + token
      },
      body: JSON.stringify({
        "branchName":"master",
      })
    };
    request(options, (error, response, body) => {
      if (error) {
        console.error('Error: ' + error.message);
        return;
      }
      console.log(body);
    });
  }
  main()
};
