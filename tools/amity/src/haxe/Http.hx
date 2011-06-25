//
// Flambe - Rapid game development
// https://github.com/aduros/amity/blob/master/LICENSE.txt

package haxe;

class Http
{
    public var url :String;

    public function new (url :String)
    {
        this.url = url;
        _headers = new Hash();
        _params = new Hash();
    }

    public function setHeader (header :String, value :String)
    {
        _headers.set(header, value);
    }

    public function setParameter (param :String, value :String)
    {
        _params.set(param, value);
    }

    public function request (post :Bool) :Void
    {
        var self = this;
        var req = amity.Net.createHttpRequest(url);
        req.onStatus = function (status) {
            self.onStatus(status);
        };
        req.onComplete = function (data) {
            self.onData(data);
	};
	req.onError = function (msg) {
	    self.onError(msg);
        };
        for (header in _headers.keys()) {
            req.setHeader(header, _headers.get(header));
        }

        var postData = null;
        if (post) {
            for (param in _params.keys()) {
                if (postData != null) {
                    postData += "&";
                } else {
                    postData = "";
                }
                postData += StringTools.urlEncode(param) +
                    "=" + StringTools.urlEncode(_params.get(param));
            }
        }
        req.send(postData);
    }

    public dynamic function onData (data :String) {
    }

    public dynamic function onError (msg :String) {
    }

    public dynamic function onStatus (status :Int) {
    }

    private var _headers :Hash<String>;
    private var _params :Hash<String>;
}
