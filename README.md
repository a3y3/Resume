# Resume
This repo contains tex files for my Resume. You can [click here](https://github.com/a3y3/Resume/blob/master/Resume_Soham_Dongargaonkar.pdf) to access it.

### PDF
I was using a `.docx` format (using Google Docs) until now because apparently ATS scanners work better with that compared to `.pdf`. However, I discovered that my Resume loooked completely messed up on different environments, like Pages on Mac. Besides, formatting was a pain with docs; for some reason every time I refreshed the page Google Docs would add the last line of my Resume on the next page.

Hence, I'm just going to trust ATS scanners to work with PDF well enough. This way it also allows me to change stuff really fast without worrying about small changes completely messing up the formatting, and it also allows me to use slots.

### Slots
I've designed the main tex file to use "slots". Since different jobs usually have wildly different requirements (and you're supposed to use only one page for your Resume no matter what), every sub section is its own tex file under one of the folders in the repo. Thus, changing a subsection (for example a project) is as simple as changing the name of the file of the project inside the main text file:
```
\begin{cvsection}{Software Projects}
  \input{projects/katalog}
  \input{projects/ripcom}
  \input{projects/beats}
\end{cvsection}
```
