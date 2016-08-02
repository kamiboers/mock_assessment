//= require page

describe('getLinks', function () {
  
  it('retrieves a list of all links', function () {
    var links = getLinks();

    assert.equal(links.length, 2);
  });
});