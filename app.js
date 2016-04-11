(function () {
"use strict";

var table;

function normalizeEmoticon (text) {
	return text.replace(/\|/g, 'I').replace(/[´`]/g, '\'').toLowerCase();
}

function normalizeText (text) {
	return text.toLowerCase();
}

function compare (a, b, type) {
	var f = type ? normalizeEmoticon : normalizeText;
	return f(a).indexOf(f(b)) > -1;
}

function filterCategory (category) {
	table.className = category ? 'category-filtered filter-' + category : '';
}

function filterContent (content) {
	var i, rows, row;
	rows = table.tBodies[0].rows;
	for (i = 0; i < rows.length; i++) {
		row = rows[i];
		row.classList[matches(row, content) ? 'remove' : 'add']('text-filter-no-match');
	}
}

function matches (row, content) {
	return compare(row.cells[0].textContent, content, true) || compare(row.cells[1].textContent, content);
}

function init () {
	var category, search;
	table = document.getElementsByTagName('table')[0];
	category = document.getElementById('category');
	search = document.getElementById('search');
	category.addEventListener('change', function () {
		filterCategory(category.value);
	}, false);
	search.addEventListener('input', function () {
		filterContent(search.value);
	}, false);
}

init();

})();