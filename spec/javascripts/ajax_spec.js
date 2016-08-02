//= require page
const sinon = require('sinon');
const assert = require('assert');

describe('removeSpace', function () {
  it('removes spaces from a string', function () {
    var str = 'I have spaces';
    var result = 'Ihavespaces';
    assert.equal(removeSpace(str), result);
  });
});