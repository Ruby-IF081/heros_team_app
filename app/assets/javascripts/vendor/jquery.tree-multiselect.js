/* jQuery Tree Multiselect v2.4.0 | (c) Patrick Tsai | MIT Licensed */ ! function e(t, i, s) {
    function n(a, o) {
        if (!i[a]) {
            if (!t[a]) {
                var c = "function" == typeof require && require;
                if (!o && c) return c(a, !0);
                if (r) return r(a, !0);
                var l = new Error("Cannot find module '" + a + "'");
                throw l.code = "MODULE_NOT_FOUND", l
            }
            var d = i[a] = {
                exports: {}
            };
            t[a][0].call(d.exports, function(e) {
                var i = t[a][1][e];
                return n(i || e)
            }, d, d.exports, e, t, i, s)
        }
        return i[a].exports
    }
    for (var r = "function" == typeof require && require, a = 0; a < s.length; a++) n(s[a]);
    return n
}({
    1: [function(e, t, i) {
        "use strict";

        function s(e) {
            e = e || {}, this.treeId = e.treeId, this.id = e.id, this.name = e.name, this.items = [], this.node = null
        }

        function n(e) {
            e = e || {}, this.treeId = e.treeId, this.id = e.id, this.value = e.value, this.text = e.text, this.description = e.description, this.initialIndex = e.initialIndex ? parseInt(e.initialIndex) : null, this.section = e.section, this.disabled = e.disabled, this.selected = e.selected, this.node = null
        }
        var r = e("./utility");
        s.prototype.isSection = function() {
            return !0
        }, s.prototype.isItem = function() {
            return !1
        }, s.prototype.render = function(e, t) {
            return this.node || (this.node = r.dom.createSection(this, e, t)), this.node
        }, n.prototype.isSection = function() {
            return !1
        }, n.prototype.isItem = function() {
            return !0
        }, n.prototype.render = function(e, t) {
            return this.node || (this.node = r.dom.createSelection(this, e, t)), this.node
        }, i.createLookup = function(e) {
            return {
                arr: e,
                children: {}
            }
        }, i.createSection = function(e) {
            return new s(e)
        }, i.createItem = function(e) {
            return new n(e)
        }
    }, {
        "./utility": 9
    }],
    2: [function(e, t, i) {
        "use strict";

        function s(e) {
            var t = {
                allowBatchSelection: !0,
                collapsible: !0,
                enableSelectAll: !1,
                selectAllText: "Select All",
                unselectAllText: "Unselect All",
                freeze: !1,
                hideSidePanel: !1,
                onChange: null,
                onlyBatchSelection: !1,
                searchable: !1,
                searchParams: ["value", "text", "description", "section"],
                sectionDelimiter: "/",
                showSectionOnSelected: !0,
                sortable: !1,
                startCollapsed: !1
            };
            return jQuery.extend({}, t, e)
        }
        var n = e("./tree"),
            r = 0;
        t.exports = function(e) {
            var t = this,
                i = s(e);
            return this.map(function() {
                var e = t;
                e.attr("multiple", "").css("display", "none");
                var s = new n(r, e, i);
                return s.initialize(), ++r, {
                    reload: function() {
                        s.reload()
                    },
                    remove: function() {
                        s.remove()
                    }
                }
            })
        }
    }, {
        "./tree": 5
    }],
    3: [function(e, t, i) {
        "use strict";

        function s(e, t, i) {
            this.index = {}, this.astItems = e, this.astItemKeys = Object.keys(e), this.astSections = t, this.astSectionKeys = Object.keys(t), this.setSearchParams(i), this.buildIndex()
        }

        function n(e) {
            if (r.assert(e), e.length < a) return [e];
            for (var t = [], i = 0; i < e.length - a + 1; ++i) t.push(e.substring(i, i + a));
            return t
        }
        var r = e("./utility"),
            a = 3;
        s.prototype.setSearchParams = function(e) {
            r.assert(Array.isArray(e));
            var t = {
                value: !0,
                text: !0,
                description: !0,
                section: !0
            };
            this.searchParams = [];
            for (var i = 0; i < e.length; ++i) t[e[i]] && this.searchParams.push(e[i])
        }, s.prototype.buildIndex = function() {
            var e = this;
            for (var t in this.astItems) ! function(t) {
                var i = e.astItems[t],
                    s = [];
                e.searchParams.forEach(function(e) {
                    s.push(i[e])
                }), r.array.removeFalseyExceptZero(s), s.map(function(e) {
                    return e.toLowerCase()
                }).forEach(function(t) {
                    t.split(" ").forEach(function(t) {
                        e._addToIndex(t, i.id)
                    })
                })
            }(t)
        }, s.prototype._addToIndex = function(e, t) {
            for (var i = 1; i <= a; ++i)
                for (var s = 0; s < e.length - i + 1; ++s) {
                    var n = e.substring(s, s + i);
                    this.index[n] || (this.index[n] = []);
                    var r = this.index[n].length;
                    0 !== r && this.index[n][r - 1] === t || this.index[n].push(t)
                }
        }, s.prototype.search = function(e) {
            var t = this;
            if (!e) return this.astItemKeys.forEach(function(e) {
                t.astItems[e].node.style.display = ""
            }), void this.astSectionKeys.forEach(function(e) {
                t.astSections[e].node.style.display = "", t.astSections[e].node.removeAttribute("searchhit")
            });
            var i = [];
            (e = e.toLowerCase()).split(" ").forEach(function(e) {
                n(e).forEach(function(e) {
                    i.push(t.index[e] || [])
                })
            });
            var s = r.array.intersectMany(i);
            this._handleNodeVisbilities(s)
        }, s.prototype._handleNodeVisbilities = function(e) {
            var t = this,
                i = {},
                s = {};
            e.forEach(function(e) {
                i[e] = !0;
                var n = t.astItems[e].node;
                for (n.style.display = "", n = n.parentNode; !n.className.match(/tree-multiselect/);) {
                    if (n.className.match(/section/)) {
                        var a = r.getKey(n);
                        if (r.assert(a || 0 === a), s[a]) break;
                        s[a] = !0, n.style.display = "", n.setAttribute("searchhit", !0)
                    }
                    n = n.parentNode
                }
            }), this.astItemKeys.forEach(function(e) {
                i[e] || (t.astItems[e].node.style.display = "none")
            }), this.astSectionKeys.forEach(function(e) {
                s[e] || (t.astSections[e].node.style.display = "none")
            })
        }, t.exports = s
    }, {
        "./utility": 9
    }],
    4: [function(e, t, i) {
        "use strict";
        jQuery.fn.treeMultiselect = e("./main")
    }, {
        "./main": 2
    }],
    5: [function(e, t, i) {
        "use strict";

        function s(e) {
            if (Array.isArray(e)) {
                for (var t = 0, i = Array(e.length); t < e.length; t++) i[t] = e[t];
                return i
            }
            return Array.from(e)
        }

        function n(e, t, i) {
            this.id = e, this.$originalSelect = t, this.params = i, this.resetState()
        }
        var r = e("./ast"),
            a = e("./search"),
            o = e("./ui-builder"),
            c = e("./utility");
        n.prototype.initialize = function() {
            if (this.generateSelections(this.$selectionContainer[0]), this.popupDescriptionHover(), this.params.allowBatchSelection && this.handleSectionCheckboxMarkings(), this.params.collapsible && this.addCollapsibility(), this.params.searchable || this.params.enableSelectAll) {
                var e = c.dom.createNode("div", {
                    class: "auxiliary"
                });
                this.$selectionContainer.prepend(e, this.$selectionContainer.firstChild), this.params.searchable && this.createSearchBar(e), this.params.enableSelectAll && this.createSelectAllButtons(e)
            }
            this.armRemoveSelectedOnClick(), this.updateSelectedAndOnChange(), this.render(!0), this.uiBuilder.attach()
        }, n.prototype.remove = function() {
            this.uiBuilder.remove(), this.resetState()
        }, n.prototype.reload = function() {
            this.remove(), this.initialize()
        }, n.prototype.resetState = function() {
            this.uiBuilder = new o(this.$originalSelect, this.params.hideSidePanel), this.$treeContainer = this.uiBuilder.$treeContainer, this.$selectionContainer = this.uiBuilder.$selectionContainer, this.$selectedContainer = this.uiBuilder.$selectedContainer, this.astItems = {}, this.astSections = {}, this.selectedNodes = {}, this.selectedKeys = [], this.keysToAdd = [], this.keysToRemove = []
        }, n.prototype.generateSelections = function(e) {
            var t = this.$originalSelect.children("option"),
                i = this.createAst(t);
            this.generateHtml(i, e)
        }, n.prototype.createAst = function(e) {
            var t, i = [],
                s = r.createLookup(i),
                n = this,
                a = 0,
                o = 0,
                l = [];
            return e.each(function() {
                var e = this;
                e.setAttribute("data-key", a);
                var t = r.createItem({
                    treeId: n.id,
                    id: a,
                    value: e.value,
                    text: e.text,
                    description: e.getAttribute("data-description"),
                    initialIndex: e.getAttribute("data-index"),
                    section: e.getAttribute("data-section"),
                    disabled: e.hasAttribute("readonly"),
                    selected: e.hasAttribute("selected")
                });
                t.initialIndex ? n.keysToAdd[t.initialIndex] = a : t.selected && l.push(a), n.astItems[a] = t, ++a;
                for (var i = s, c = t.section, d = c && c.length > 0 ? c.split(n.params.sectionDelimiter) : [], h = 0; h < d.length; ++h) {
                    var u = d[h];
                    if (i.children[u]) i = i.children[u];
                    else {
                        var p = r.createSection({
                            treeId: n.id,
                            id: o,
                            name: u
                        });
                        ++o, i.arr.push(p);
                        var f = r.createLookup(p.items);
                        i.children[u] = f, i = f
                    }
                }
                i.arr.push(t)
            }), c.array.removeFalseyExceptZero(this.keysToAdd), (t = this.keysToAdd).push.apply(t, l), c.array.uniq(this.keysToAdd), i
        }, n.prototype.generateHtml = function(e, t) {
            for (var i = 0; i < e.length; ++i) {
                var s = e[i];
                if (s.isSection()) {
                    this.astSections[s.id] = s;
                    var n = this.params.allowBatchSelection,
                        r = this.params.freeze,
                        a = s.render(n, r);
                    t.appendChild(a), this.generateHtml(s.items, a)
                } else if (s.isItem()) {
                    this.astItems[s.id] = s;
                    var o = !this.params.onlyBatchSelection,
                        c = this.params.freeze,
                        l = s.render(o, c);
                    t.appendChild(l)
                }
            }
        }, n.prototype.popupDescriptionHover = function() {
            this.$selectionContainer.on("mouseenter", "div.item > span.description", function() {
                var e = jQuery(this).parent(),
                    t = e.attr("data-description"),
                    i = document.createElement("div");
                i.className = "temp-description-popup", i.innerHTML = t, i.style.position = "absolute", e.append(i)
            }), this.$selectionContainer.on("mouseleave", "div.item > span.description", function() {
                jQuery(this).parent().find("div.temp-description-popup").remove()
            })
        }, n.prototype.handleSectionCheckboxMarkings = function() {
            var e = this;
            this.$selectionContainer.on("click", "input.section[type=checkbox]", function() {
                var t = jQuery(this).closest("div.section").find("div.item").map(function(t, i) {
                    var s = c.getKey(i);
                    if (!e.astItems[s].disabled) return s
                }).get();
                if (this.checked) {
                    var i;
                    (i = e.keysToAdd).push.apply(i, s(t)), c.array.uniq(e.keysToAdd)
                } else {
                    var n;
                    (n = e.keysToRemove).push.apply(n, s(t)), c.array.uniq(e.keysToRemove)
                }
                e.render()
            })
        }, n.prototype.redrawSectionCheckboxes = function(e) {
            var t = 3,
                i = this;
            if ((e = e || this.$selectionContainer).find("> div.section").each(function() {
                    var e = i.redrawSectionCheckboxes(jQuery(this));
                    t &= e
                }), t)
                for (var s = e.find("> div.item > input[type=checkbox]"), n = 0; n < s.length && (s[n].disabled || (s[n].checked ? t &= -3 : t &= -2), 0 !== t); ++n);
            var r = e.find("> div.title > input[type=checkbox]");
            return r.length && (r = r[0], 1 & t ? (r.checked = !0, r.indeterminate = !1) : 2 & t ? (r.checked = !1, r.indeterminate = !1) : (r.checked = !1, r.indeterminate = !0)), t
        }, n.prototype.addCollapsibility = function() {
            var e = this.$selectionContainer.find("div.title"),
                t = c.dom.createNode("span", {
                    class: "collapse-section"
                });
            e.prepend(t);
            var i = this.$selectionContainer.find("div.section");
            this.params.startCollapsed && i.addClass("collapsed"), this.$selectionContainer.on("click", "div.title", function(e) {
                "INPUT" !== e.target.nodeName && (jQuery(this).parent().toggleClass("collapsed"), e.stopPropagation())
            })
        }, n.prototype.createSearchBar = function(e) {
            var t = new a(this.astItems, this.astSections, this.params.searchParams),
                i = c.dom.createNode("input", {
                    class: "search",
                    placeholder: "Search..."
                });
            e.appendChild(i), this.$selectionContainer.on("input", "input.search", function() {
                var e = this.value;
                t.search(e)
            })
        }, n.prototype.createSelectAllButtons = function(e) {
            var t = c.dom.createNode("span", {
                    class: "select-all",
                    text: this.params.selectAllText
                }),
                i = c.dom.createNode("span", {
                    class: "unselect-all",
                    text: this.params.unselectAllText
                }),
                n = c.dom.createNode("div", {
                    class: "select-all-container"
                });
            n.appendChild(t), n.appendChild(i), e.appendChild(n);
            var r = this;
            this.$selectionContainer.on("click", "span.select-all", function() {
                r.keysToAdd = Object.keys(r.astItems), r.render()
            }), this.$selectionContainer.on("click", "span.unselect-all", function() {
                var e;
                (e = r.keysToRemove).push.apply(e, s(r.selectedKeys)), r.render()
            })
        }, n.prototype.armRemoveSelectedOnClick = function() {
            var e = this;
            this.$selectedContainer.on("click", "span.remove-selected", function() {
                var t = this.parentNode,
                    i = c.getKey(t);
                e.keysToRemove.push(i), e.render()
            })
        }, n.prototype.updateSelectedAndOnChange = function() {
            var e = this;
            if (this.$selectionContainer.on("click", "input.option[type=checkbox]", function() {
                    var t = this,
                        i = t.parentNode,
                        s = c.getKey(i);
                    c.assert(s || 0 === s), t.checked ? e.keysToAdd.push(s) : e.keysToRemove.push(s), e.render()
                }), this.params.sortable && !this.params.freeze) {
                var t = null,
                    i = null;
                this.$selectedContainer.sortable({
                    start: function(e, i) {
                        t = i.item.index()
                    },
                    stop: function(s, n) {
                        i = n.item.index(), t !== i && (c.array.moveEl(e.selectedKeys, t, i), e.render())
                    }
                })
            }
        }, n.prototype.render = function(e) {
            var t, i = this;
            c.array.uniq(this.keysToAdd), c.array.uniq(this.keysToRemove), c.array.subtract(this.keysToAdd, this.selectedKeys), c.array.intersect(this.keysToRemove, this.selectedKeys);
            for (var n = 0; n < this.keysToRemove.length; ++n) {
                var r = this.selectedNodes[this.keysToRemove[n]];
                r && (r.parentNode.removeChild(r), this.selectedNodes[this.keysToRemove[n]] = null), this.astItems[this.keysToRemove[n]].node.getElementsByTagName("INPUT")[0].checked = !1
            }
            c.array.subtract(this.selectedKeys, this.keysToRemove);
            for (var a = 0; a < this.keysToAdd.length; ++a) {
                var o = this.keysToAdd[a],
                    l = this.astItems[o];
                this.selectedKeys.push(o);
                var d = c.dom.createSelected(l, this.params.freeze, this.params.showSectionOnSelected);
                this.selectedNodes[l.id] = d, this.$selectedContainer.append(d);
                var h = l.node.getElementsByTagName("INPUT")[0];
                h && (h.checked = !0)
            }(t = this.selectedKeys).push.apply(t, s(this.keysToAdd)), c.array.uniq(this.selectedKeys), this.redrawSectionCheckboxes();
            for (var u = {}, p = {}, f = 0; f < this.selectedKeys.length; ++f) {
                var v = this.astItems[this.selectedKeys[f]].value;
                u[this.selectedKeys[f]] = !0, p[v] = f
            }
            var y = this.$originalSelect.find("option").toArray();
            if (y.sort(function(e, t) {
                    return (p[e.value] || 0) - (p[t.value] || 0)
                }), this.$originalSelect.html(y), this.$originalSelect.find("option").each(function(e, t) {
                    this.selected = !!u[c.getKey(t)]
                }), this.$originalSelect.change(), !e && this.params.onChange) {
                var m = this.selectedKeys.map(function(e) {
                        return i.astItems[e]
                    }),
                    k = this.keysToAdd.map(function(e) {
                        return i.astItems[e]
                    }),
                    x = this.keysToRemove.map(function(e) {
                        return i.astItems[e]
                    });
                this.params.onChange(m, k, x)
            }
            this.keysToRemove = [], this.keysToAdd = []
        }, t.exports = n
    }, {
        "./ast": 1,
        "./search": 3,
        "./ui-builder": 6,
        "./utility": 9
    }],
    6: [function(e, t, i) {
        "use strict";

        function s(e, t) {
            var i = jQuery('<div class="tree-multiselect"></div>'),
                s = jQuery('<div class="selections"></div>');
            t && s.addClass("no-border"), i.append(s);
            var n = jQuery('<div class="selected"></div>');
            t || i.append(n), this.$el = e, this.$treeContainer = i, this.$selectionContainer = s, this.$selectedContainer = n
        }
        s.prototype.attach = function() {
            this.$el.after(this.$treeContainer)
        }, s.prototype.remove = function() {
            this.$treeContainer.remove()
        }, t.exports = s
    }, {}],
    7: [function(e, t, i) {
        "use strict";

        function s(e, t) {
            for (var i = 0, s = 0; s < e.length; ++s) t(e[s]) && (e[i] = e[s], ++i);
            e.length = i
        }
        i.uniq = function(e) {
            var t = {};
            s(e, function(e) {
                var i = !t[e];
                return t[e] = !0, i
            })
        }, i.removeFalseyExceptZero = function(e) {
            s(e, function(e) {
                return e || 0 === e
            })
        }, i.moveEl = function(e, t, i) {
            var s = e[t];
            e.splice(t, 1), e.splice(i, 0, s)
        }, i.subtract = function(e, t) {
            for (var i = {}, n = 0; n < t.length; ++n) i[t[n]] = !0;
            s(e, function(e) {
                return !i[e]
            })
        }, i.intersect = function(e, t) {
            for (var i = {}, n = 0; n < t.length; ++n) i[t[n]] = !0;
            s(e, function(e) {
                return i[e]
            })
        }, i.intersectMany = function(e) {
            var t = [],
                i = [];
            e.forEach(function(e) {
                t.push(0), i.push(e.length - 1)
            });
            for (var s = []; t.length > 0 && t[0] <= i[0]; ++t[0]) {
                for (var n = !1, r = 1; r < e.length; ++r) {
                    for (; e[r][t[r]] < e[0][t[0]] && t[r] <= i[r];) ++t[r];
                    if (t[r] > i[r]) {
                        n = !0;
                        break
                    }
                }
                if (n) break;
                for (var a = !0, o = 1; o < e.length; ++o)
                    if (e[0][t[0]] !== e[o][t[o]]) {
                        a = !1;
                        break
                    }
                a && s.push(e[0][t[0]])
            }
            return s
        }
    }, {}],
    8: [function(e, t, i) {
        "use strict";
        i.createNode = function(e, t) {
            var i = document.createElement(e);
            if (t) {
                for (var s in t) t.hasOwnProperty(s) && "text" !== s && i.setAttribute(s, t[s]);
                t.text && (i.textContent = t.text)
            }
            return i
        }, i.createSelection = function(e, t, s) {
            var n = {
                    class: "item",
                    "data-key": e.id,
                    "data-value": e.value
                },
                r = !!e.description;
            r && (n["data-description"] = e.description), e.initialIndex && (n["data-index"] = e.initialIndex);
            var a = i.createNode("div", n);
            if (r) {
                var o = i.createNode("span", {
                    class: "description",
                    text: "?"
                });
                a.appendChild(o)
            }
            if (t) {
                var c = "treemultiselect-" + e.treeId + "-" + e.id,
                    l = {
                        class: "option",
                        type: "checkbox",
                        id: c
                    };
                (s || e.disabled) && (l.disabled = !0);
                var d = i.createNode("input", l);
                a.insertBefore(d, a.firstChild);
                var h = {
                        class: e.disabled ? "disabled" : "",
                        for: c,
                        text: e.text || e.value
                    },
                    u = i.createNode("label", h);
                a.appendChild(u)
            } else a.innerText = e.text || e.value;
            return a
        }, i.createSelected = function(e, t, s) {
            var n = i.createNode("div", {
                class: "item",
                "data-key": e.id,
                "data-value": e.value,
                text: e.text
            });
            if (s) {
                var a = i.createNode("span", {
                    class: "section-name",
                    text: e.section
                });
                n.insertBefore(a, n.firstChild)
            }
            if (!t && !e.disabled) {
                var r = i.createNode("span", {
                    class: "remove-selected",
                    text: "×"
                });
                n.insertBefore(r, n.firstChild)
            }
            var clearfix = i.createNode('div', { class: 'clearfix' });
            n.appendChild(clearfix)
            return n
        }, i.createSection = function(e, t, s) {
            var n = i.createNode("div", {
                    class: "section",
                    "data-key": e.id
                }),
                r = i.createNode("div", {
                    class: "title",
                    text: e.name
                });
            if (t) {
                var a = {
                    class: "section",
                    type: "checkbox"
                };
                s && (a.disabled = !0);
                var o = i.createNode("input", a);
                r.insertBefore(o, r.firstChild)
            }
            return n.appendChild(r), n
        }
    }, {}],
    9: [function(e, t, i) {
        "use strict";
        i.array = e("./array"), i.assert = function(e, t) {
            if (!e) throw new Error(t || "Assertion failed")
        }, i.dom = e("./dom"), i.getKey = function(e) {
            return i.assert(e), parseInt(e.getAttribute("data-key"))
        }
    }, {
        "./array": 7,
        "./dom": 8
    }]
}, {}, [4]);
