var exec = require('cordova/exec');

exports.sendLTV = function(conversionID, success, error) {
    exec(success, error, "FOXiOS", "sendLTV", [conversionID]);
};

exports.sendLTVPurchase = function(conversionID, price, currency, itemName, success, error) {
    exec(success, error, "FOXiOS", "sendLTV", [conversionID, price, currency, itemName]);
};
