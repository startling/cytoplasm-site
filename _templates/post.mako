<%inherit file="/_templates/site.mako"/>
<h1> ${post.title} </h1>
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
${post.contents}
