/**
 * Triggered from a message on a Cloud Pub/Sub topic.
 *
 * @param {!Object} event Event payload.
 * @param {!Object} context Metadata for the event.
 */
var googleapis = require("googleapis");
var request = require("request");
exports.gke_node_scalse = (event, context) => {
  const message = event.data
    ? Buffer.from(event.data, 'base64').toString()
    : 'update start';
  console.log(message);
    async function main() {
    const token = await googleapis.google.auth.getAccessToken();
    console.log(token);
    var options = {
      // url: "https://cloudbuild.googleapis.com/v1/projects/YOUR_GCP_PJ_ID/triggers/YOUR_CLOUD_BUUILD_TRIGGER_ID:run"
      url: "https://cloudbuild.googleapis.com/v1/projects/" + event.attributes._gcp_pj_id + "/triggers/" + event.attributes._trigger_id + ":run",
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
