
var jsDomEnv = require('jsdom').env;
	assert = require('assert');

describe('Node module setup', function() {
	var $, xhr, win;
	
	beforeEach(function(done) {
		jsDomEnv('<html></html>', function (error, window) {
			if (error) {
				console.error('jsdom initialization failed');
				assert(false);
			} else {
				win = window;
				$ = require('jquery')(window);
				xhr = require('xmlhttprequest').XMLHttpRequest;
				$.support.cors = true;
				$.ajaxSettings.xhr = function () {
					return new xhr();
				};
			}
			done();
		});
	});
	
	describe('Mockjax Node Module Tests', function() {
	
		afterEach(function() {
			if ($ && $.mockjax) {
				$.mockjax.clear();
			}
		});
		
		
		it('should be loaded when required', function() {
			var mockjax = require('../../src/jquery.mockjax')($, win);
			assert.equal(typeof mockjax, 'function');
			assert.equal(typeof $.mockjax, 'function');
		});
		
		it('should mock a simple request using returned module', function(done) {
			var mockjax = require('../../src/jquery.mockjax')($, win);
			
			mockjax({
				url: '/resource',
				responseText: 'content'
			});

			$.ajax({
				url: '/resource',
				success: function(response) {
					assert.equal(response, 'content');
				},
				error: function () {
					console.error('error callback executed!');
					assert(false);
				},
				complete: function () {
					done();
				}
			});
		});
		
		it('should mock a simple request using $.mockjax', function(done) {
			require('../../src/jquery.mockjax')($, win);
			
			$.mockjax({
				url: '/foo',
				responseText: 'bar'
			});

			$.ajax({
				url: '/foo',
				success: function(response) {
					assert.equal(response, 'bar');
				},
				error: function () {
					console.error('error callback executed!');
					assert(false);
				},
				complete: function () {
					done();
				}
			});
		});
	});
});
