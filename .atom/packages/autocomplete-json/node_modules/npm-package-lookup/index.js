var fetch = require('node-fetch');
var queryString = require('query-string');
var semverStable = require('semver-stable');
var semver = require('semver-utils');
var memoize = require('lodash.memoize');

// Url for prefix searching npm repositories
function getSearchUrl(keyword, limit) {
  limit = limit || 50;
  // URL shamelessly appropriated from Microsoft/vscode
  return 'https://skimdb.npmjs.com/registry/_design/app/_view/browseAll?' + queryString.stringify({
    group_level: 1,
    limit: limit,
    start_key: '["' + keyword + '"]',
    end_key: '["' + (keyword + 'z') + '",{}]'
  });
}
  
// Url for getting information about a specific repository
function getPackageUrl(name) {
  return "http://registry.npmjs.org/" + name;
}

// utility, so I don't have to call .json() on each request
function fetchJson(url, options) {
  return fetch(url, options).then(function (response) {
    return response.json();
  });
}

// returns a Promise, with the {name, description} objects of the matching packages
function search(keyword) {
  return fetchJson(getSearchUrl(keyword)).then(function (results) {
    return (results.rows || []).map(function (row) {
      return row.key[0];
    });
  });
}

// Returns all the available versions for the given package in reverse order (newest first)
function versions(name, options) {
  options = options || {};
  var stable = !!options.stable;
  var sort = options.sort ? (options.sort.toString().toUpperCase() === 'ASC' ? 1 : -1) : false;

  return fetchJson(getPackageUrl(name)).then(function (packageInfo) {
    var versionsObject = packageInfo.versions || {};
    var vers = Object.keys(versionsObject);
    if (stable) {
      vers = vers.filter(function (version) {
        return semverStable.is(version);
      });
    }
    if (sort) {
      var parse = memoize(function parse(version) {
        return semver.parse(version);
      });
      var compare = function compareSemvers(a, b) {
        a = parse(a);
        b = parse(b);
        if (a.major !== b.major) {
          return (a.major || 0) - (b.major || 0);
        }
        if (a.minor !== b.minor) {
          return (a.minor || 0) - (b.minor || 0);
        }
        if (a.patch !== b.patch) {
          return (a.patch || 0) - (b.patch || 0);
        }
        return 0;
      };
      var compareWithSortOrder = function (a, b) {
        return sort * compare(a, b);
      }
      vers = vers.sort(compareWithSortOrder);
    }
    return vers;
  });
}

module.exports = {
  search: search,
  versions: versions
};
