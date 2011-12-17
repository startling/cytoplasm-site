<%inherit file="/_templates/site.mako"/>
<%def name="excerpt(post)">
## return the first 150 words of this post
##${"".join(post.contents.split(" ")[150])}    
${post.contents}
</%def>

% for post in posts:
<h1> <a href="/blog/${post.url}">${post.title}</a></h1>
<p class="subtitle">
    Posted on 
    <a href="/blog/${post.year}/${post.month}">${post.month}</a>
    /
    ${post.day}
    /
    <a href="/blog/${post.year}">${post.year}</a>
% if len(post.tags) != 0:
    to
    % for tag in post.tags:
        % if tag != post.tags[-1]:
    <a href="/blog/${tag}">${tag}</a>,
        % else:
    <a href="/blog/${tag}">${tag}</a>
        % endif
    % endfor
% endif
</p>
${excerpt(post)}
% endfor

