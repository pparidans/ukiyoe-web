{% extends "../layouts/default.swig" %}

{% block title %}{{ __("Index Page") }}{% endblock %}

{% block content %}
{% macro fullArtistName(name) %}{{ name.name }}{% if name.given_kanji %}<span class="artist_name_kanji">{% if name.surname_kanji %}
        (<ruby>
        {{ name.surname_kanji }}
        <rp>(</rp><rt>{{ name.surname_kana }}</rt><rp>)</rp>
        </ruby>
    {% endif %}<ruby>
    {{ name.given_kanji }}
    <rp>(</rp><rt>{{ name.given_kana }}</rt><rp>)</rp>
    </ruby>{% if name.generation %}&nbsp;{{ name.generation }}世{% endif %}){% else %}{% if name.kanji %}(<ruby class="artist_kanji">
        {{ name.kanji }}
        <rp>(</rp><rt>{{ name.kana }}</rt><rp>)</rp>
    </ruby>){% endif %}{% endif %}</span>{% endmacro %}

{% if artist %}
<div class="row">
    <h1 class="col-xs-12 artist_name">
        {{ artist.name.name }}

        {% if artist.name.given_kanji %}
        <span class="artist_name_kanji">
        {% if artist.name.surname_kanji %}
            (<ruby>
            {{ artist.name.surname_kanji }}
            <rp>(</rp><rt>{{ artist.name.surname_kana }}</rt><rp>)</rp>
            </ruby>
        {% else %}
        ({% endif %}<ruby>
        {{ artist.name.given_kanji }}
        <rp>(</rp><rt>{{ artist.name.given_kana }}</rt><rp>)</rp>
        </ruby>{% if artist.name.generation %}
            &nbsp;{{ artist.name.generation }}世{% endif %})
        {% else %}
        {% if artist.name.kanji %}
        (<ruby class="artist_kanji">
            {{ artist.name.kanji }}
            <rp>(</rp><rt>{{ artist.name.kana }}</rt><rp>)</rp>
        </ruby>)
        {% endif %}
        </span>
        {% endif %}
    </h1>
</div>

{% if start == 1 %}
{% if artist.life.start %}
<div class="row">
    <div class="col-xs-12">
    {% if artist.life.start %}
        <strong>{{ __("Born:") }}</strong>
        {% if artist.life.start_ca %}{{ __("ca. ") }}{% endif %}
        {{artist.life.start}}
    {% endif %}
    &dash;
    {% if artist.life.end %}
        <strong>{{ __("Died:") }}</strong>
        {% if artist.life.end_ca %}{{ __("ca. ") }}{% endif %}
        {{artist.life.end}}
    {% endif %}
    {% if artist.life.current %}
        {{ __("Alive") }}
    {% endif %}
    </div>
</div>
{% endif %}
{% if artist.active.start %}
<div class="row">
    <div class="col-xs-12">
        <strong>{{ __("Active:") }}</strong>
        {% if artist.active.start %}
            {% if artist.active.start_ca %}{{ __("ca. ") }}{% endif %}
            {{artist.active.start}}
        {% endif %}
        &dash;
        {% if artist.active.end %}
            {% if artist.active.end_ca %}{{ __("ca. ") }}{% endif %}
            {{artist.active.end}}
        {% endif %}
        {% if artist.active.current %}
            {{ __("Alive") }}
        {% endif %}
    </div>
</div>
{% endif %}
{% if artist.aliases %}
<div class="row">
    <div class="col-xs-12">
        <strong>{{ __("Aliases:") }}</strong>
        {% for name in artist.aliases %}
            {{ fullArtistName(name) }}{% if !loop.last %}, {% endif %}
        {% endfor %}
    </div>
</div>
{% endif %}

{% if bio %}
<div class="row">
    <div class="col-xs-12">
        <blockquote class="bio">{{ bio }}</blockquote>
    </div>
</div>
{% endif %}

<div class="row">
    <div class="col-xs-12">
        <strong>{{ __("Bios:") }}</strong>
        {% for bio in artist.bios %}
            <a href="{{ bio.url }}">{{ fullArtistName(bio.name) }}{% if bio.source %} ({{ fullName(bio.source) }}){% endif %}</a>{% if !loop.last %}, {% endif %}
        {% endfor %}
    </div>
</div>

{% else %}

{% endif %}

{% else %}

<div class="row">
    <h1 class="col-md-12">{{ title }}</h1>
    {% if url %}
        <p class="col-md-12"><a href="{{ url }}">{{ url }}</a></p>
    {% endif %}
</div>

{% endif %}

<div id="results">
    <div class="state row">
        <div class="col-md-12">
            <span class="total">{{ __("<strong>%s</strong> prints found.", stringNum(total))|raw }}</span>
            <span class="page">{{ __("Viewing prints %s to %s.", stringNum(start), stringNum(end)) }}</span>
        </div>
    </div>

<!--
<p><input type="hidden" id="selectArtist" style="width:500px;"/></p>

<form action="/images/search" method="GET">
<p>Query: <input type="search" name="q" value="{{q}}"/></p>
<p>
    <input type="text" size="2" name="startDate" value="{{startDate}}"/>
    <div class="slider"></div>
    <input type="text" size="2" name="endDate" value="{{endDate}}"/>
</p>
<p><input type="submit" value="Search"/></p>
</form>
-->

<div class="row">
{% for image in images %}
<div class="img">
    <a class="img" href="{{ URL(image) }}"
        title="{{ getTitle(image) }}">
    <img src="{{ image.getThumbURL() }}"
        alt="{{ getTitle(image) }}"
        title="{{ getTitle(image) }}"/></a>
    <div class="details">
        <div class="wrap">
        {% if image.artist %}
            {% if image.artist.artist %}
                <a class="artist" href="{{ URL(image.artist.artist) }}"
                    title="{{ fullName(image.artist.artist) }}">
                    {{ shortName(image.artist.artist) }}</a>
            {% endif %}
        {% endif %}
        <a class="source" href="{{ URL(image.source) }}"
            title="{{ fullName(image.source) }}">
            {{ shortName(image.source) }}</a>
        </div>
    </div>
</div>
{% endfor %}
</div>

<div class="search-nav row col-md-12">
    {% if prev %}
        <span class="prev"><a href="{{ prev }}" class="btn btn-primary"
            rel="prev">&laquo; {{ __("Previous") }}</a></span>
    {% endif %}

    {% if next %}
        <span class="next"><a href="{{ next }}" class="btn btn-primary"
            rel="next">{{ __("Next") }} &raquo;</a></span>
    {% endif %}
</div>

</div>

{% endblock %}