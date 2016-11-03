var fetch = require('node-fetch');
var semverStable = require('semver-stable');
var semver = require('semver-utils');
var memoize = require('lodash.memoize');
  
// URL for searching packages
function getSearchByNameUrl(query) {
  return "https://packagist.org/search.json?q=" + query;
}

// URL for looking up info about a specific package
function getPackageInfoUrl(packageName) {
  var parts = packageName.split('/');
  if (parts.length !== 2) {
    throw new Error('Invalid package name: "' + packageName + '"');
  }
  var vendor = parts[0];
  var name = parts[1];
  return "https://packagist.org/packages/" + vendor + "/" + name + ".json"
}

function getSearchByVendorUrl(vendor) {
  return "https://packagist.org/packages/list.json?vendor=" + vendor;
}

// utility, so I don't have to call .json() on each request
function fetchJson(url, options) {
  return fetch(url, options).then(function (response) {
    return response.json();
  });
}

// Returns a Promise, with the {name, description} objects of the matching packages
function searchByName(keyword) {
  return fetchJson(getSearchByNameUrl(keyword)).then(function (json) {
    return json.results;
  });
}
// Returns all the available versions for the given package in reverse order (newest first)
function versions(packageName, options) {
  options = options || {};
  var stable = !!options.stable;
  var sort = options.sort ? (options.sort.toString().toUpperCase() === 'ASC' ? 1 : -1) : false;

  return fetchJson(getPackageInfoUrl(packageName)).then(function (json) {
    var vers = Object.keys(((json || {}).package || {}).versions || []);
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
        a = parse(a) || {};
        b = parse(b) || {};
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

// Returns the packages by the given vendor.
function searchByVendor(vendor) {
  return fetchJson(getSearchByVendorUrl(vendor)).then(function (json) {
    return ((json || {}).packageNames) || [];
  });
}

module.exports = {
  searchByName: searchByName,
  searchByVendor: searchByVendor,
  versions: versions
};
