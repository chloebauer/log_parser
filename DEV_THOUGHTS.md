Hi, this file is mostly for me to let my thoughts be known since you can't ask me quesitons.

So firstly, sorry I wrote this on my desktop windows PC and thus did not simulate a unix environment.
What I want to talk about here is how I went about doing this, originally I wanted to use File.readline, 
but after reading this article (https://felipeelias.github.io/ruby/2017/01/02/fast-file-processing-ruby.html)

The writer called out how horrible `File.readline` was for what I was trying to do. So I sat down and did some googling, found some stack overflow links and it turns out Ruby kinda sucks for large file reading.
Since I have used log readers that worked heavy off gulp and regex in the past I knew the speed of what I was looking for, but was not sure I could get there in ruby.
I considered using python briefly, but I did not find anything that would give me a huge increase. 
Besides, I already was working in Ruby and I accepted the downsides. Also writing this w/o libraries meant I was a bit on my own.
So I decided to go with `IO.foreach` and am fairly happy with it. 

I will also mention: I very briefly considered writing this in flask to be more liteweight than a full on rails app for one api call, but my python and flask was rusty so i stuck with what I used most recently

Now, when it comes to the production readyness of the code: It's all right. It isn't the cleanest, but I was focused more on getting it into a state that solves the problems.
I am sure there are edge cases that I am missing, but I tried to cover some of the more obvious ones.

Hope you like it!