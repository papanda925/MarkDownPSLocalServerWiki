|FileName|LineNumber|Line|Pattern|
|:-|:-|:-|:-|
|[【ページ一覧】](【ページ一覧】)|1||FileName|CreationTime|LastWriteTime||a|
|[トップページ](トップページ)|11|Markdown: Syntax|a|
|[トップページ](トップページ)|15|    <li><a href="/projects/markdown/" title="Markdown Project Page">Main</a></li>|a|
|[トップページ](トップページ)|16|    <li><a href="/projects/markdown/basics" title="Markdown Basics">Basics</a></li>|a|
|[トップページ](トップページ)|17|    <li><a class="selected" title="Markdown Syntax Documentation">Syntax</a></li>|a|
|[トップページ](トップページ)|18|    <li><a href="/projects/markdown/license" title="Pricing and License Information">License</a></li>|a|
|[トップページ](トップページ)|19|    <li><a href="/projects/markdown/dingus" title="Online Markdown Web Form">Dingus</a></li>|a|
|[トップページ](トップページ)|26|    *   [Automatic Escaping for Special Characters](#autoescape)|a|
|[トップページ](トップページ)|28|    *   [Paragraphs and Line Breaks](#p)|a|
|[トップページ](トップページ)|29|    *   [Headers](#header)|a|
|[トップページ](トップページ)|33|    *   [Horizontal Rules](#hr)|a|
|[トップページ](トップページ)|34|*   [Span Elements](#span)|a|
|[トップページ](トップページ)|36|    *   [Emphasis](#em)|a|
|[トップページ](トップページ)|38|    *   [Images](#img)|a|
|[トップページ](トップページ)|39|*   [Miscellaneous](#misc)|a|
|[トップページ](トップページ)|40|    *   [Backslash Escapes](#backslash)|a|
|[トップページ](トップページ)|41|    *   [Automatic Links](#autolink)|a|
|[トップページ](トップページ)|44|**Note:** This document is itself written using Markdown; you|a|
|[トップページ](トップページ)|45|can [see the source for it by adding '.text' to the URL][src].|a|
|[トップページ](トップページ)|47|  [src]: /projects/markdown/syntax.text|a|
|[トップページ](トップページ)|55|Markdown is intended to be as easy-to-read and easy-to-write as is feasible.|a|
|[トップページ](トップページ)|57|Readability, however, is emphasized above all else. A Markdown-formatted|a|
|[トップページ](トップページ)|58|document should be publishable as-is, as plain text, without looking|a|
|[トップページ](トップページ)|59|like it's been marked up with tags or formatting instructions. While|a|
|[トップページ](トップページ)|60|Markdown's syntax has been influenced by several existing text-to-HTML|a|
|[トップページ](トップページ)|61|filters -- including [Setext] [1], [atx] [2], [Textile] [3], [reStructuredText] [4],|a|
|[トップページ](トップページ)|62|[Grutatext] [5], and [EtText] [6] -- the single biggest source of|a|
|[トップページ](トップページ)|63|inspiration for Markdown's syntax is the format of plain text email.|a|
|[トップページ](トップページ)|66|  [2]: http://www.aaronsw.com/2002/atx/|a|
|[トップページ](トップページ)|69|  [5]: http://www.triptico.com/software/grutatxt.html|a|
|[トップページ](トップページ)|70|  [6]: http://ettext.taint.org/doc/|a|
|[トップページ](トップページ)|72|To this end, Markdown's syntax is comprised entirely of punctuation|a|
|[トップページ](トップページ)|73|characters, which punctuation characters have been carefully chosen so|a|
|[トップページ](トップページ)|74|as to look like what they mean. E.g., asterisks around a word actually|a|
|[トップページ](トップページ)|75|look like \*emphasis\*. Markdown lists look like, well, lists. Even|a|
|[トップページ](トップページ)|76|blockquotes look like quoted passages of text, assuming you've ever|a|
|[トップページ](トップページ)|77|used email.|a|
|[トップページ](トップページ)|83|Markdown's syntax is intended for one purpose: to be used as a|a|
|[トップページ](トップページ)|84|format for *writing* for the web.|a|
|[トップページ](トップページ)|86|Markdown is not a replacement for HTML, or even close to it. Its|a|
|[トップページ](トップページ)|87|syntax is very small, corresponding only to a very small subset of|a|
|[トップページ](トップページ)|88|HTML tags. The idea is *not* to create a syntax that makes it easier|a|
|[トップページ](トップページ)|89|to insert HTML tags. In my opinion, HTML tags are already easy to|a|
|[トップページ](トップページ)|90|insert. The idea for Markdown is to make it easy to read, write, and|a|
|[トップページ](トップページ)|91|edit prose. HTML is a *publishing* format; Markdown is a *writing*|a|
|[トップページ](トップページ)|92|format. Thus, Markdown's formatting syntax only addresses issues that|a|
|[トップページ](トップページ)|93|can be conveyed in plain text.|a|
|[トップページ](トップページ)|95|For any markup that is not covered by Markdown's syntax, you simply|a|
|[トップページ](トップページ)|96|use HTML itself. There's no need to preface it or delimit it to|a|
|[トップページ](トップページ)|97|indicate that you're switching from Markdown to HTML; you just use|a|
|[トップページ](トップページ)|98|the tags.|a|
|[トップページ](トップページ)|100|The only restrictions are that block-level HTML elements -- e.g. `<div>`,|a|
|[トップページ](トップページ)|101|`<table>`, `<pre>`, `<p>`, etc. -- must be separated from surrounding|a|
|[トップページ](トップページ)|102|content by blank lines, and the start and end tags of the block should|a|
|[トップページ](トップページ)|103|not be indented with tabs or spaces. Markdown is smart enough not|a|
|[トップページ](トップページ)|104|to add extra (unwanted) `<p>` tags around HTML block-level tags.|a|
|[トップページ](トップページ)|106|For example, to add an HTML table to a Markdown article:|a|
|[トップページ](トップページ)|108|    This is a regular paragraph.|a|
|[トップページ](トップページ)|110|    <table>|a|
|[トップページ](トップページ)|114|    </table>|a|
|[トップページ](トップページ)|116|    This is another regular paragraph.|a|
|[トップページ](トップページ)|118|Note that Markdown formatting syntax is not processed within block-level|a|
|[トップページ](トップページ)|119|HTML tags. E.g., you can't use Markdown-style `*emphasis*` inside an|a|
|[トップページ](トップページ)|122|Span-level HTML tags -- e.g. `<span>`, `<cite>`, or `<del>` -- can be|a|
|[トップページ](トップページ)|123|used anywhere in a Markdown paragraph, list item, or header. If you|a|
|[トップページ](トップページ)|124|want, you can even use HTML tags instead of Markdown formatting; e.g. if|a|
|[トップページ](トップページ)|125|you'd prefer to use HTML `<a>` or `<img>` tags instead of Markdown's|a|
|[トップページ](トップページ)|126|link or image syntax, go right ahead.|a|
|[トップページ](トップページ)|128|Unlike block-level HTML tags, Markdown syntax *is* processed within|a|
|[トップページ](トップページ)|129|span-level tags.|a|
|[トップページ](トップページ)|132|<h3 id="autoescape">Automatic Escaping for Special Characters</h3>|a|
|[トップページ](トップページ)|134|In HTML, there are two characters that demand special treatment: `<`|a|
|[トップページ](トップページ)|135|and `&`. Left angle brackets are used to start tags; ampersands are|a|
|[トップページ](トップページ)|136|used to denote HTML entities. If you want to use them as literal|a|
|[トップページ](トップページ)|137|characters, you must escape them as entities, e.g. `<`, and|a|
|[トップページ](トップページ)|140|Ampersands in particular are bedeviling for web writers. If you want to|a|
|[トップページ](トップページ)|141|write about 'AT&T', you need to write '`AT&T`'. You even need to|a|
|[トップページ](トップページ)|142|escape ampersands within URLs. Thus, if you want to link to:|a|
|[トップページ](トップページ)|144|    http://images.google.com/images?num=30&q=larry+bird|a|
|[トップページ](トップページ)|146|you need to encode the URL as:|a|
|[トップページ](トップページ)|148|    http://images.google.com/images?num=30&q=larry+bird|a|
|[トップページ](トップページ)|150|in your anchor tag `href` attribute. Needless to say, this is easy to|a|
|[トップページ](トップページ)|151|forget, and is probably the single most common source of HTML validation|a|
|[トップページ](トップページ)|152|errors in otherwise well-marked-up web sites.|a|
|[トップページ](トップページ)|154|Markdown allows you to use these characters naturally, taking care of|a|
|[トップページ](トップページ)|155|all the necessary escaping for you. If you use an ampersand as part of|a|
|[トップページ](トップページ)|156|an HTML entity, it remains unchanged; otherwise it will be translated|a|
|[トップページ](トップページ)|159|So, if you want to include a copyright symbol in your article, you can write:|a|
|[トップページ](トップページ)|163|and Markdown will leave it alone. But if you write:|a|
|[トップページ](トップページ)|165|    AT&T|a|
|[トップページ](トップページ)|167|Markdown will translate it to:|a|
|[トップページ](トップページ)|169|    AT&T|a|
|[トップページ](トップページ)|171|Similarly, because Markdown supports [inline HTML](#html), if you use|a|
|[トップページ](トップページ)|172|angle brackets as delimiters for HTML tags, Markdown will treat them as|a|
|[トップページ](トップページ)|177|Markdown will translate it to:|a|
|[トップページ](トップページ)|181|However, inside Markdown code spans and blocks, angle brackets and|a|
|[トップページ](トップページ)|182|ampersands are *always* encoded automatically. This makes it easy to use|a|
|[トップページ](トップページ)|183|Markdown to write about HTML code. (As opposed to raw HTML, which is a|a|
|[トップページ](トップページ)|184|terrible format for writing about HTML syntax, because every single `<`|a|
|[トップページ](トップページ)|185|and `&` in your example code needs to be escaped.)|a|
|[トップページ](トップページ)|194|<h3 id="p">Paragraphs and Line Breaks</h3>|a|
|[トップページ](トップページ)|196|A paragraph is simply one or more consecutive lines of text, separated|a|
|[トップページ](トップページ)|197|by one or more blank lines. (A blank line is any line that looks like a|a|
|[トップページ](トップページ)|198|blank line -- a line containing nothing but spaces or tabs is considered|a|
|[トップページ](トップページ)|199|blank.) Normal paragraphs should not be intended with spaces or tabs.|a|
|[トップページ](トップページ)|201|The implication of the "one or more consecutive lines of text" rule is|a|
|[トップページ](トップページ)|202|that Markdown supports "hard-wrapped" text paragraphs. This differs|a|
|[トップページ](トップページ)|203|significantly from most other text-to-HTML formatters (including Movable|a|
|[トップページ](トップページ)|204|Type's "Convert Line Breaks" option) which translate every line break|a|
|[トップページ](トップページ)|205|character in a paragraph into a `<br />` tag.|a|
|[トップページ](トップページ)|207|When you *do* want to insert a `<br />` break tag using Markdown, you|a|
|[トップページ](トップページ)|208|end a line with two or more spaces, then type return.|a|
|[トップページ](トップページ)|210|Yes, this takes a tad more effort to create a `<br />`, but a simplistic|a|
|[トップページ](トップページ)|211|"every line break is a `<br />`" rule wouldn't work for Markdown.|a|
|[トップページ](トップページ)|212|Markdown's email-style [blockquoting][bq] and multi-paragraph [list items][l]|a|
|[トップページ](トップページ)|213|work best -- and look better -- when you format them with hard breaks.|a|
|[トップページ](トップページ)|220|<h3 id="header">Headers</h3>|a|
|[トップページ](トップページ)|222|Markdown supports two styles of headers, [Setext] [1] and [atx] [2].|a|
|[トップページ](トップページ)|224|Setext-style headers are "underlined" using equal signs (for first-level|a|
|[トップページ](トップページ)|225|headers) and dashes (for second-level headers). For example:|a|
|[トップページ](トップページ)|227|    This is an H1|a|
|[トップページ](トップページ)|230|    This is an H2|a|
|[トップページ](トップページ)|233|Any number of underlining `=`'s or `-`'s will work.|a|
|[トップページ](トップページ)|235|Atx-style headers use 1-6 hash characters at the start of the line,|a|
|[トップページ](トップページ)|236|corresponding to header levels 1-6. For example:|a|
|[トップページ](トップページ)|238|    # This is an H1|a|
|[トップページ](トップページ)|240|    ## This is an H2|a|
|[トップページ](トップページ)|242|    ###### This is an H6|a|
|[トップページ](トップページ)|244|Optionally, you may "close" atx-style headers. This is purely|a|
|[トップページ](トップページ)|245|cosmetic -- you can use this if you think it looks better. The|a|
|[トップページ](トップページ)|246|closing hashes don't even need to match the number of hashes|a|
|[トップページ](トップページ)|247|used to open the header. (The number of opening hashes|a|
|[トップページ](トップページ)|248|determines the header level.) :|a|
|[トップページ](トップページ)|250|    # This is an H1 #|a|
|[トップページ](トップページ)|252|    ## This is an H2 ##|a|
|[トップページ](トップページ)|254|    ### This is an H3 ######|a|
|[トップページ](トップページ)|259|Markdown uses email-style `>` characters for blockquoting. If you're|a|
|[トップページ](トップページ)|260|familiar with quoting passages of text in an email message, then you|a|
|[トップページ](トップページ)|261|know how to create a blockquote in Markdown. It looks best if you hard|a|
|[トップページ](トップページ)|262|wrap the text and put a `>` before every line:|a|
|[トップページ](トップページ)|264|    > This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,|a|
|[トップページ](トップページ)|265|    > consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.|a|
|[トップページ](トップページ)|266|    > Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.|a|
|[トップページ](トップページ)|268|    > Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse|a|
|[トップページ](トップページ)|269|    > id sem consectetuer libero luctus adipiscing.|a|
|[トップページ](トップページ)|271|Markdown allows you to be lazy and only put the `>` before the first|a|
|[トップページ](トップページ)|272|line of a hard-wrapped paragraph:|a|
|[トップページ](トップページ)|274|    > This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,|a|
|[トップページ](トップページ)|275|    consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.|a|
|[トップページ](トップページ)|276|    Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.|a|
|[トップページ](トップページ)|278|    > Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse|a|
|[トップページ](トップページ)|279|    id sem consectetuer libero luctus adipiscing.|a|
|[トップページ](トップページ)|281|Blockquotes can be nested (i.e. a blockquote-in-a-blockquote) by|a|
|[トップページ](トップページ)|282|adding additional levels of `>`:|a|
|[トップページ](トップページ)|288|    > Back to the first level.|a|
|[トップページ](トップページ)|290|Blockquotes can contain other Markdown elements, including headers, lists,|a|
|[トップページ](トップページ)|291|and code blocks:|a|
|[トップページ](トップページ)|293|	> ## This is a header.|a|
|[トップページ](トップページ)|298|	> Here's some example code:|a|
|[トップページ](トップページ)|300|	>     return shell_exec("echo $input | $markdown_script");|a|
|[トップページ](トップページ)|302|Any decent text editor should make email-style quoting easy. For|a|
|[トップページ](トップページ)|303|example, with BBEdit, you can make a selection and choose Increase|a|
|[トップページ](トップページ)|309|Markdown supports ordered (numbered) and unordered (bulleted) lists.|a|
|[トップページ](トップページ)|311|Unordered lists use asterisks, pluses, and hyphens -- interchangably|a|
|[トップページ](トップページ)|312|-- as list markers:|a|
|[トップページ](トップページ)|318|is equivalent to:|a|
|[トップページ](トップページ)|324|and:|a|
|[トップページ](トップページ)|333|    2.  McHale|a|
|[トップページ](トップページ)|334|    3.  Parish|a|
|[トップページ](トップページ)|336|It's important to note that the actual numbers you use to mark the|a|
|[トップページ](トップページ)|337|list have no effect on the HTML output Markdown produces. The HTML|a|
|[トップページ](トップページ)|338|Markdown produces from the above list is:|a|
|[トップページ](トップページ)|342|    <li>McHale</li>|a|
|[トップページ](トップページ)|343|    <li>Parish</li>|a|
|[トップページ](トップページ)|346|If you instead wrote the list in Markdown like this:|a|
|[トップページ](トップページ)|349|    1.  McHale|a|
|[トップページ](トップページ)|350|    1.  Parish|a|
|[トップページ](トップページ)|355|    1. McHale|a|
|[トップページ](トップページ)|356|    8. Parish|a|
|[トップページ](トップページ)|358|you'd get the exact same HTML output. The point is, if you want to,|a|
|[トップページ](トップページ)|359|you can use ordinal numbers in your ordered Markdown lists, so that|a|
|[トップページ](トップページ)|360|the numbers in your source match the numbers in your published HTML.|a|
|[トップページ](トップページ)|361|But if you want to be lazy, you don't have to.|a|
|[トップページ](トップページ)|363|If you do use lazy list numbering, however, you should still start the|a|
|[トップページ](トップページ)|364|list with the number 1. At some point in the future, Markdown may support|a|
|[トップページ](トップページ)|365|starting ordered lists at an arbitrary number.|a|
|[トップページ](トップページ)|367|List markers typically start at the left margin, but may be indented by|a|
|[トップページ](トップページ)|368|up to three spaces. List markers must be followed by one or more spaces|a|
|[トップページ](トップページ)|369|or a tab.|a|
|[トップページ](トップページ)|371|To make lists look nice, you can wrap items with hanging indents:|a|
|[トップページ](トップページ)|373|    *   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.|a|
|[トップページ](トップページ)|374|        Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,|a|
|[トップページ](トップページ)|375|        viverra nec, fringilla in, laoreet vitae, risus.|a|
|[トップページ](トップページ)|376|    *   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.|a|
|[トップページ](トップページ)|377|        Suspendisse id sem consectetuer libero luctus adipiscing.|a|
|[トップページ](トップページ)|379|But if you want to be lazy, you don't have to:|a|
|[トップページ](トップページ)|381|    *   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.|a|
|[トップページ](トップページ)|382|    Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,|a|
|[トップページ](トップページ)|383|    viverra nec, fringilla in, laoreet vitae, risus.|a|
|[トップページ](トップページ)|384|    *   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.|a|
|[トップページ](トップページ)|385|    Suspendisse id sem consectetuer libero luctus adipiscing.|a|
|[トップページ](トップページ)|387|If list items are separated by blank lines, Markdown will wrap the|a|
|[トップページ](トップページ)|388|items in `<p>` tags in the HTML output. For example, this input:|a|
|[トップページ](トップページ)|391|    *   Magic|a|
|[トップページ](トップページ)|397|    <li>Magic</li>|a|
|[トップページ](トップページ)|404|    *   Magic|a|
|[トップページ](トップページ)|410|    <li><p>Magic</p></li>|a|
|[トップページ](トップページ)|413|List items may consist of multiple paragraphs. Each subsequent|a|
|[トップページ](トップページ)|414|paragraph in a list item must be intended by either 4 spaces|a|
|[トップページ](トップページ)|415|or one tab:|a|
|[トップページ](トップページ)|417|    1.  This is a list item with two paragraphs. Lorem ipsum dolor|a|
|[トップページ](トップページ)|418|        sit amet, consectetuer adipiscing elit. Aliquam hendrerit|a|
|[トップページ](トップページ)|421|        Vestibulum enim wisi, viverra nec, fringilla in, laoreet|a|
|[トップページ](トップページ)|422|        vitae, risus. Donec sit amet nisl. Aliquam semper ipsum|a|
|[トップページ](トップページ)|423|        sit amet velit.|a|
|[トップページ](トップページ)|425|    2.  Suspendisse id sem consectetuer libero luctus adipiscing.|a|
|[トップページ](トップページ)|428|paragraphs, but here again, Markdown will allow you to be|a|
|[トップページ](トップページ)|429|lazy:|a|
|[トップページ](トップページ)|431|    *   This is a list item with two paragraphs.|a|
|[トップページ](トップページ)|433|        This is the second paragraph in the list item. You're|a|
|[トップページ](トップページ)|435|    sit amet, consectetuer adipiscing elit.|a|
|[トップページ](トップページ)|437|    *   Another item in the same list.|a|
|[トップページ](トップページ)|439|To put a blockquote within a list item, the blockquote's `>`|a|
|[トップページ](トップページ)|442|    *   A list item with a blockquote:|a|
|[トップページ](トップページ)|444|        > This is a blockquote|a|
|[トップページ](トップページ)|445|        > inside a list item.|a|
|[トップページ](トップページ)|447|To put a code block within a list item, the code block needs|a|
|[トップページ](トップページ)|448|to be indented *twice* -- 8 spaces or two tabs:|a|
|[トップページ](トップページ)|450|    *   A list item with a code block:|a|
|[トップページ](トップページ)|455|It's worth noting that it's possible to trigger an ordered list by|a|
|[トップページ](トップページ)|456|accident, by writing something like this:|a|
|[トップページ](トップページ)|458|    1986. What a great season.|a|
|[トップページ](トップページ)|460|In other words, a *number-period-space* sequence at the beginning of a|a|
|[トップページ](トップページ)|461|line. To avoid this, you can backslash-escape the period:|a|
|[トップページ](トップページ)|463|    1986\. What a great season.|a|
|[トップページ](トップページ)|469|Pre-formatted code blocks are used for writing about programming or|a|
|[トップページ](トップページ)|470|markup source code. Rather than forming normal paragraphs, the lines|a|
|[トップページ](トップページ)|471|of a code block are interpreted literally. Markdown wraps a code block|a|
|[トップページ](トップページ)|472|in both `<pre>` and `<code>` tags.|a|
|[トップページ](トップページ)|474|To produce a code block in Markdown, simply indent every line of the|a|
|[トップページ](トップページ)|475|block by at least 4 spaces or 1 tab. For example, given this input:|a|
|[トップページ](トップページ)|477|    This is a normal paragraph:|a|
|[トップページ](トップページ)|479|        This is a code block.|a|
|[トップページ](トップページ)|481|Markdown will generate:|a|
|[トップページ](トップページ)|483|    <p>This is a normal paragraph:</p>|a|
|[トップページ](トップページ)|485|    <pre><code>This is a code block.|a|
|[トップページ](トップページ)|488|One level of indentation -- 4 spaces or 1 tab -- is removed from each|a|
|[トップページ](トップページ)|489|line of the code block. For example, this:|a|
|[トップページ](トップページ)|491|    Here is an example of AppleScript:|a|
|[トップページ](トップページ)|493|        tell application "Foo"|a|
|[トップページ](トップページ)|499|    <p>Here is an example of AppleScript:</p>|a|
|[トップページ](トップページ)|501|    <pre><code>tell application "Foo"|a|
|[トップページ](トップページ)|506|A code block continues until it reaches a line that is not indented|a|
|[トップページ](トップページ)|507|(or the end of the article).|a|
|[トップページ](トップページ)|509|Within a code block, ampersands (`&`) and angle brackets (`<` and `>`)|a|
|[トップページ](トップページ)|510|are automatically converted into HTML entities. This makes it very|a|
|[トップページ](トップページ)|511|easy to include example HTML source code using Markdown -- just paste|a|
|[トップページ](トップページ)|512|it and indent it, and Markdown will handle the hassle of encoding the|a|
|[トップページ](トップページ)|513|ampersands and angle brackets. For example, this:|a|
|[トップページ](トップページ)|515|        <div class="footer">|a|
|[トップページ](トップページ)|516|            © 2004 Foo Corporation|a|
|[トップページ](トップページ)|521|    <pre><code><div class="footer">|a|
|[トップページ](トップページ)|522|        © 2004 Foo Corporation|a|
|[トップページ](トップページ)|526|Regular Markdown syntax is not processed within code blocks. E.g.,|a|
|[トップページ](トップページ)|527|asterisks are just literal asterisks within a code block. This means|a|
|[トップページ](トップページ)|528|it's also easy to use Markdown to write about Markdown's own syntax.|a|
|[トップページ](トップページ)|532|<h3 id="hr">Horizontal Rules</h3>|a|
|[トップページ](トップページ)|534|You can produce a horizontal rule tag (`<hr />`) by placing three or|a|
|[トップページ](トップページ)|535|more hyphens, asterisks, or underscores on a line by themselves. If you|a|
|[トップページ](トップページ)|536|wish, you may use spaces between the hyphens or asterisks. Each of the|a|
|[トップページ](トップページ)|537|following lines will produce a horizontal rule:|a|
|[トップページ](トップページ)|554|<h2 id="span">Span Elements</h2>|a|
|[トップページ](トップページ)|558|Markdown supports two style of links: *inline* and *reference*.|a|
|[トップページ](トップページ)|560|In both styles, the link text is delimited by [square brackets].|a|
|[トップページ](トップページ)|562|To create an inline link, use a set of regular parentheses immediately|a|
|[トップページ](トップページ)|563|after the link text's closing square bracket. Inside the parentheses,|a|
|[トップページ](トップページ)|564|put the URL where you want the link to point, along with an *optional*|a|
|[トップページ](トップページ)|565|title for the link, surrounded in quotes. For example:|a|
|[トップページ](トップページ)|567|    This is [an example](http://example.com/ "Title") inline link.|a|
|[トップページ](トップページ)|569|    [This link](http://example.net/) has no title attribute.|a|
|[トップページ](トップページ)|573|    <p>This is <a href="http://example.com/" title="Title">|a|
|[トップページ](トップページ)|574|    an example</a> inline link.</p>|a|
|[トップページ](トップページ)|576|    <p><a href="http://example.net/">This link</a> has no|a|
|[トップページ](トップページ)|577|    title attribute.</p>|a|
|[トップページ](トップページ)|579|If you're referring to a local resource on the same server, you can|a|
|[トップページ](トップページ)|580|use relative paths:|a|
|[トップページ](トップページ)|582|    See my [About](/about/) page for details.|a|
|[トップページ](トップページ)|584|Reference-style links use a second set of square brackets, inside|a|
|[トップページ](トップページ)|585|which you place a label of your choosing to identify the link:|a|
|[トップページ](トップページ)|587|    This is [an example][id] reference-style link.|a|
|[トップページ](トップページ)|589|You can optionally use a space to separate the sets of brackets:|a|
|[トップページ](トップページ)|591|    This is [an example] [id] reference-style link.|a|
|[トップページ](トップページ)|593|Then, anywhere in the document, you define your link label like this,|a|
|[トップページ](トップページ)|594|on a line by itself:|a|
|[トップページ](トップページ)|596|    [id]: http://example.com/  "Optional Title Here"|a|
|[トップページ](トップページ)|598|That is:|a|
|[トップページ](トップページ)|600|*   Square brackets containing the link identifier (optionally|a|
|[トップページ](トップページ)|601|    indented from the left margin using up to three spaces);|a|
|[トップページ](トップページ)|602|*   followed by a colon;|a|
|[トップページ](トップページ)|603|*   followed by one or more spaces (or tabs);|a|
|[トップページ](トップページ)|605|*   optionally followed by a title attribute for the link, enclosed|a|
|[トップページ](トップページ)|608|The link URL may, optionally, be surrounded by angle brackets:|a|
|[トップページ](トップページ)|610|    [id]: <http://example.com/>  "Optional Title Here"|a|
|[トップページ](トップページ)|612|You can put the title attribute on the next line and use extra spaces|a|
|[トップページ](トップページ)|613|or tabs for padding, which tends to look better with longer URLs:|a|
|[トップページ](トップページ)|615|    [id]: http://example.com/longish/path/to/resource/here|a|
|[トップページ](トップページ)|616|        "Optional Title Here"|a|
|[トップページ](トップページ)|618|Link definitions are only used for creating links during Markdown|a|
|[トップページ](トップページ)|619|processing, and are stripped from your document in the HTML output.|a|
|[トップページ](トップページ)|621|Link definition names may constist of letters, numbers, spaces, and punctuation -- but they are *not* case sensitive. E.g. these two links:|a|
|[トップページ](トップページ)|623|	[link text][a]|a|
|[トップページ](トップページ)|624|	[link text][A]|a|
|[トップページ](トップページ)|626|are equivalent.|a|
|[トップページ](トップページ)|628|The *implicit link name* shortcut allows you to omit the name of the|a|
|[トップページ](トップページ)|629|link, in which case the link text itself is used as the name.|a|
|[トップページ](トップページ)|630|Just use an empty set of square brackets -- e.g., to link the word|a|
|[トップページ](トップページ)|635|And then define the link:|a|
|[トップページ](トップページ)|639|Because link names may contain spaces, this shortcut even works for|a|
|[トップページ](トップページ)|642|	Visit [Daring Fireball][] for more information.|a|
|[トップページ](トップページ)|644|And then define the link:|a|
|[トップページ](トップページ)|646|	[Daring Fireball]: http://daringfireball.net/|a|
|[トップページ](トップページ)|648|Link definitions can be placed anywhere in your Markdown document. I|a|
|[トップページ](トップページ)|649|tend to put them immediately after each paragraph in which they're|a|
|[トップページ](トップページ)|650|used, but if you want, you can put them all at the end of your|a|
|[トップページ](トップページ)|653|Here's an example of reference links in action:|a|
|[トップページ](トップページ)|655|    I get 10 times more traffic from [Google] [1] than from|a|
|[トップページ](トップページ)|656|    [Yahoo] [2] or [MSN] [3].|a|
|[トップページ](トップページ)|659|      [2]: http://search.yahoo.com/  "Yahoo Search"|a|
|[トップページ](トップページ)|660|      [3]: http://search.msn.com/    "MSN Search"|a|
|[トップページ](トップページ)|662|Using the implicit link name shortcut, you could instead write:|a|
|[トップページ](トップページ)|664|    I get 10 times more traffic from [Google][] than from|a|
|[トップページ](トップページ)|665|    [Yahoo][] or [MSN][].|a|
|[トップページ](トップページ)|668|      [yahoo]:  http://search.yahoo.com/  "Yahoo Search"|a|
|[トップページ](トップページ)|669|      [msn]:    http://search.msn.com/    "MSN Search"|a|
|[トップページ](トップページ)|671|Both of the above examples will produce the following HTML output:|a|
|[トップページ](トップページ)|673|    <p>I get 10 times more traffic from <a href="http://google.com/"|a|
|[トップページ](トップページ)|674|    title="Google">Google</a> than from|a|
|[トップページ](トップページ)|675|    <a href="http://search.yahoo.com/" title="Yahoo Search">Yahoo</a>|a|
|[トップページ](トップページ)|676|    or <a href="http://search.msn.com/" title="MSN Search">MSN</a>.</p>|a|
|[トップページ](トップページ)|678|For comparison, here is the same paragraph written using|a|
|[トップページ](トップページ)|679|Markdown's inline link style:|a|
|[トップページ](トップページ)|681|    I get 10 times more traffic from [Google](http://google.com/ "Google")|a|
|[トップページ](トップページ)|682|    than from [Yahoo](http://search.yahoo.com/ "Yahoo Search") or|a|
|[トップページ](トップページ)|683|    [MSN](http://search.msn.com/ "MSN Search").|a|
|[トップページ](トップページ)|685|The point of reference-style links is not that they're easier to|a|
|[トップページ](トップページ)|686|write. The point is that with reference-style links, your document|a|
|[トップページ](トップページ)|687|source is vastly more readable. Compare the above examples: using|a|
|[トップページ](トップページ)|688|reference-style links, the paragraph itself is only 81 characters|a|
|[トップページ](トップページ)|689|long; with inline-style links, it's 176 characters; and as raw HTML,|a|
|[トップページ](トップページ)|690|it's 234 characters. In the raw HTML, there's more markup than there|a|
|[トップページ](トップページ)|693|With Markdown's reference-style links, a source document much more|a|
|[トップページ](トップページ)|694|closely resembles the final output, as rendered in a browser. By|a|
|[トップページ](トップページ)|695|allowing you to move the markup-related metadata out of the paragraph,|a|
|[トップページ](トップページ)|696|you can add links without interrupting the narrative flow of your|a|
|[トップページ](トップページ)|700|<h3 id="em">Emphasis</h3>|a|
|[トップページ](トップページ)|702|Markdown treats asterisks (`*`) and underscores (`_`) as indicators of|a|
|[トップページ](トップページ)|703|emphasis. Text wrapped with one `*` or `_` will be wrapped with an|a|
|[トップページ](トップページ)|704|HTML `<em>` tag; double `*`'s or `_`'s will be wrapped with an HTML|a|
|[トップページ](トップページ)|705|`<strong>` tag. E.g., this input:|a|
|[トップページ](トップページ)|707|    *single asterisks*|a|
|[トップページ](トップページ)|711|    **double asterisks**|a|
|[トップページ](トップページ)|717|    <em>single asterisks</em>|a|
|[トップページ](トップページ)|721|    <strong>double asterisks</strong>|a|
|[トップページ](トップページ)|725|You can use whichever style you prefer; the lone restriction is that|a|
|[トップページ](トップページ)|726|the same character must be used to open and close an emphasis span.|a|
|[トップページ](トップページ)|728|Emphasis can be used in the middle of a word:|a|
|[トップページ](トップページ)|730|    un*fucking*believable|a|
|[トップページ](トップページ)|732|But if you surround an `*` or `_` with spaces, it'll be treated as a|a|
|[トップページ](トップページ)|733|literal asterisk or underscore.|a|
|[トップページ](トップページ)|735|To produce a literal asterisk or underscore at a position where it|a|
|[トップページ](トップページ)|736|would otherwise be used as an emphasis delimiter, you can backslash|a|
|[トップページ](トップページ)|737|escape it:|a|
|[トップページ](トップページ)|739|    \*this text is surrounded by literal asterisks\*|a|
|[トップページ](トップページ)|745|To indicate a span of code, wrap it with backtick quotes (`` ` ``).|a|
|[トップページ](トップページ)|746|Unlike a pre-formatted code block, a code span indicates code within a|a|
|[トップページ](トップページ)|747|normal paragraph. For example:|a|
|[トップページ](トップページ)|755|To include a literal backtick character within a code span, you can use|a|
|[トップページ](トップページ)|756|multiple backticks as the opening and closing delimiters:|a|
|[トップページ](トップページ)|758|    ``There is a literal backtick (`) here.``|a|
|[トップページ](トップページ)|762|    <p><code>There is a literal backtick (`) here.</code></p>|a|
|[トップページ](トップページ)|764|The backtick delimiters surrounding a code span may include spaces --|a|
|[トップページ](トップページ)|765|one after the opening, one before the closing. This allows you to place|a|
|[トップページ](トップページ)|766|literal backtick characters at the beginning or end of a code span:|a|
|[トップページ](トップページ)|768|	A single backtick in a code span: `` ` ``|a|
|[トップページ](トップページ)|770|	A backtick-delimited string in a code span: `` `foo` ``|a|
|[トップページ](トップページ)|774|	<p>A single backtick in a code span: <code>`</code></p>|a|
|[トップページ](トップページ)|776|	<p>A backtick-delimited string in a code span: <code>`foo`</code></p>|a|
|[トップページ](トップページ)|778|With a code span, ampersands and angle brackets are encoded as HTML|a|
|[トップページ](トップページ)|779|entities automatically, which makes it easy to include example HTML|a|
|[トップページ](トップページ)|780|tags. Markdown will turn this:|a|
|[トップページ](トップページ)|782|    Please don't use any `<blink>` tags.|a|
|[トップページ](トップページ)|786|    <p>Please don't use any <code><blink></code> tags.</p>|a|
|[トップページ](トップページ)|788|You can write this:|a|
|[トップページ](トップページ)|790|    `—` is the decimal-encoded equivalent of `—`.|a|
|[トップページ](トップページ)|794|    <p><code>—</code> is the decimal-encoded|a|
|[トップページ](トップページ)|795|    equivalent of <code>—</code>.</p>|a|
|[トップページ](トップページ)|799|<h3 id="img">Images</h3>|a|
|[トップページ](トップページ)|801|Admittedly, it's fairly difficult to devise a "natural" syntax for|a|
|[トップページ](トップページ)|802|placing images into a plain text document format.|a|
|[トップページ](トップページ)|804|Markdown uses an image syntax that is intended to resemble the syntax|a|
|[トップページ](トップページ)|805|for links, allowing for two styles: *inline* and *reference*.|a|
|[トップページ](トップページ)|807|Inline image syntax looks like this:|a|
|[トップページ](トップページ)|809|    ![Alt text](/path/to/img.jpg)|a|
|[トップページ](トップページ)|811|    ![Alt text](/path/to/img.jpg "Optional title")|a|
|[トップページ](トップページ)|813|That is:|a|
|[トップページ](トップページ)|815|*   An exclamation mark: `!`;|a|
|[トップページ](トップページ)|816|*   followed by a set of square brackets, containing the `alt`|a|
|[トップページ](トップページ)|817|    attribute text for the image;|a|
|[トップページ](トップページ)|818|*   followed by a set of parentheses, containing the URL or path to|a|
|[トップページ](トップページ)|819|    the image, and an optional `title` attribute enclosed in double|a|
|[トップページ](トップページ)|822|Reference-style image syntax looks like this:|a|
|[トップページ](トップページ)|824|    ![Alt text][id]|a|
|[トップページ](トップページ)|826|Where "id" is the name of a defined image reference. Image references|a|
|[トップページ](トップページ)|827|are defined using syntax identical to link references:|a|
|[トップページ](トップページ)|829|    [id]: url/to/image  "Optional title attribute"|a|
|[トップページ](トップページ)|831|As of this writing, Markdown has no syntax for specifying the|a|
|[トップページ](トップページ)|832|dimensions of an image; if this is important to you, you can simply|a|
|[トップページ](トップページ)|833|use regular HTML `<img>` tags.|a|
|[トップページ](トップページ)|839|<h2 id="misc">Miscellaneous</h2>|a|
|[トップページ](トップページ)|841|<h3 id="autolink">Automatic Links</h3>|a|
|[トップページ](トップページ)|843|Markdown supports a shortcut style for creating "automatic" links for URLs and email addresses: simply surround the URL or email address with angle brackets. What this means is that if you want to show the actual text of a URL or email address, and also have it be a clickable link, you can do this:|a|
|[トップページ](トップページ)|845|    <http://example.com/>|a|
|[トップページ](トップページ)|847|Markdown will turn this into:|a|
|[トップページ](トップページ)|849|    <a href="http://example.com/">http://example.com/</a>|a|
|[トップページ](トップページ)|851|Automatic links for email addresses work similarly, except that|a|
|[トップページ](トップページ)|852|Markdown will also perform a bit of randomized decimal and hex|a|
|[トップページ](トップページ)|853|entity-encoding to help obscure your address from address-harvesting|a|
|[トップページ](トップページ)|854|spambots. For example, Markdown will turn this:|a|
|[トップページ](トップページ)|856|    <address@example.com>|a|
|[トップページ](トップページ)|860|    <a href="mailto:addre|a|
|[トップページ](トップページ)|861|    ss@example.co|a|
|[トップページ](トップページ)|862|    m">address@exa|a|
|[トップページ](トップページ)|863|    mple.com</a>|a|
|[トップページ](トップページ)|865|which will render in a browser as a clickable link to "address@example.com".|a|
|[トップページ](トップページ)|867|(This sort of entity-encoding trick will indeed fool many, if not|a|
|[トップページ](トップページ)|868|most, address-harvesting bots, but it definitely won't fool all of|a|
|[トップページ](トップページ)|869|them. It's better than nothing, but an address published in this way|a|
|[トップページ](トップページ)|870|will probably eventually start receiving spam.)|a|
|[トップページ](トップページ)|874|<h3 id="backslash">Backslash Escapes</h3>|a|
|[トップページ](トップページ)|876|Markdown allows you to use backslash escapes to generate literal|a|
|[トップページ](トップページ)|877|characters which would otherwise have special meaning in Markdown's|a|
|[トップページ](トップページ)|878|formatting syntax. For example, if you wanted to surround a word with|a|
|[トップページ](トップページ)|879|literal asterisks (instead of an HTML `<em>` tag), you can backslashes|a|
|[トップページ](トップページ)|880|before the asterisks, like this:|a|
|[トップページ](トップページ)|882|    \*literal asterisks\*|a|
|[トップページ](トップページ)|884|Markdown provides backslash escapes for the following characters:|a|
|[トップページ](トップページ)|886|    \   backslash|a|
|[トップページ](トップページ)|887|    `   backtick|a|
|[トップページ](トップページ)|888|    *   asterisk|a|
|[トップページ](トップページ)|890|    {}  curly braces|a|
|[トップページ](トップページ)|891|    []  square brackets|a|
|[トップページ](トップページ)|892|    ()  parentheses|a|
|[トップページ](トップページ)|893|    #   hash mark|a|
|[トップページ](トップページ)|897|    !   exclamation mark|a|
|[トップページ](トップページ)|904|<http://example.com>|a|
|[トップページ](トップページ)|913|This fails in markdown.pl and upskirt:|a|
|[トップページ](トップページ)|919|Link: <http://example.com/>.|a|
|[トップページ](トップページ)|921|With an ampersand: <http://example.com/?foo=1&bar=2>|a|
|[トップページ](トップページ)|923|* In a list?|a|
|[トップページ](トップページ)|924|* <http://example.com/>|a|
|[トップページ](トップページ)|927|> Blockquoted: <http://example.com/>|a|
|[トップページ](トップページ)|929|Auto-links should not occur here: `<http://example.com/>`|a|
|[トップページ](トップページ)|931|	or here: <http://example.com/>|a|
|[トップページ](トップページ)|934|[HTAファイルの作成](HTAファイルの作成)|a|
|[トップページ](トップページ)|937|[http://qiita.com](http://qiita.com)|a|
|[トップページ](トップページ)|939|[あああ](http://qiita.com  "いいいい")|a|
|[トップページ](トップページ)|941|[NASDE1150](\\NASDE1150\Public)|a|
|[トップページ](トップページ)|948|Markdown: [Qiita](http://qiita.com "aaaa")|a|
|[トップページ](トップページ)|952|Markdown: [Qiita](\\111.11.111 "aaaa")|a|
|[トップページ](トップページ)|955||size |material     |color|a|
|[トップページ](トップページ)|957||9    |leather      |brown|a|
|[トップページ](トップページ)|958||10   |hemp canvas  |natural|a|
|[トップページ](トップページ)|959||11   |glass        |transparent|a|
|[トップページ](トップページ)|961|An h1 header|a|
|[トップページ](トップページ)|964|Paragraphs are separated by a blank line.|a|
|[トップページ](トップページ)|966|2nd paragraph. *Italic*, **bold**, `monospace`. Itemized lists|a|
|[トップページ](トップページ)|970|  * that one|a|
|[トップページ](トップページ)|972|> Block quotes are|a|
|[トップページ](トップページ)|975|An h2 header|a|
|[トップページ](トップページ)|982|    # Let me re-iterate ...|a|
|[トップページ](トップページ)|986|define foobar() {|a|
|[トップページ](トップページ)|987|    print 'Welcome to flavor country!';|a|
|[トップページ](トップページ)|994|for i in range(10):|a|
|[トップページ](トップページ)|1000|### An h3 header ###|a|
|[トップページ](トップページ)|1002|Tables can look like this:|a|
|[トップページ](トップページ)|1004||size |material     |color|a|
|[トップページ](トップページ)|1006||9    |leather      |brown|a|
|[トップページ](トップページ)|1007||10   |hemp canvas  |natural|a|
|[トップページ](トップページ)|1008||11   |glass        |transparent|a|
|[トップページ](トップページ)|1024|Markdown記法サンプル用|a|
|[トップページ](トップページ)|1049|- *斜体 italicです。* _これも斜体です。_ <i>iタグです。</i>|a|
|[トップページ](トップページ)|1089|###ここにはMarkdown書式は効きません|a|
|[トップページ](トップページ)|1096|<head>|a|
|[トップページ](トップページ)|1097|<meta http-equiv="X-UA-Compatible" content="IE=edge">|a|
|[トップページ](トップページ)|1102|body { display: none; }|a|
|[トップページ](トップページ)|1106|<?php if (is_tag()){ $posts = query_posts($query_string . '&showposts=20'); } ?>|a|
|[トップページ](トップページ)|1116|![うきっ！](http://mkb.salchu.net/image/salchu_image02.jpg "salchu_image02.jpg")|a|
|[トップページ](トップページ)|1120|| Left align | Right align | Center align ||a|
|[トップページ](トップページ)|1127|| aligned    |     aligned |   aligned    ||a|
|[トップページ](トップページ)|1133|from [Markdown記法 表示確認用サンプル - Qiita](http://qiita.com/salchu/items/da81122ed50b35feda4d "Markdown記法 表示確認用サンプル - Qiita")|a|


