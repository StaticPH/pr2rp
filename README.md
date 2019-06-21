# pr2rp
Try to make creating a resource pack from a pull request _less_ agonizingly tedious. Yes, you could clone the whole repository/branch and pick out the files you want, but I don't want to do that.

This is just something I threw together quickly, so don't expect anything fancy, and there is no stupid-proofing in the script.

Requires Bash, wget, and ripgrep(see note on step 4)

# Steps
---

1. load page manually *(Because neither curl nor wget wants to load beyond the 299th changed file. Something to do with javascript delaying loading past a certain point to keep initial page load time fast.)*

2. find ```<div id="files" class="diff-view commentable">```

3. copy that entire element to a file and save to a file, let's say diffElem.txt  
> *I would recommend you use the script and skip to step 8(**Note that all parameters are required!**), but if for some reason you dont want to use the script, just proceed to step 4. Of course, the script makes steps 5 and 6 generic, while the steps themselves are written exactly as I did them.*  
> ex:  
> ```bash
> ./genResourcePack "newTinkerTextures" "https://raw.githubusercontent.com/SlimeKnights/TinkersConstruct/4722395cefb0c793d23692578ff823bc6ab458a0/" "A bunch of new textures for Tinker's construct, kindly provided by RCXcrafter([https://github.com/RCXcrafter]), and constructed according to instructions/script provided by StaticPH([https://github.com/StaticPH])."
> ```

4. *rg/ripgrep is my goto for things like this, because its sooooo much faster than grep, and doesn't require you to learn awk's grammar/syntax. If you don't want to get ripgrep, it's up to you to rewrite this using grep, or any other program of your choice.*
```bash
rg 'div class="file-header d-flex flex-items-center file-header--expandable js-file-header\s*" data-path=".*?"'| rg -o 'resources.*?"' | tr -d '"' >> assets.txt
```

5. *You could do this with curl, but I didn't feel like spending that long digging through man pages to figure it out :p*
```bash
wget -x -nH -i assets.txt --cut-dirs 4 -P newTinkerTextures -B "https://raw.githubusercontent.com/SlimeKnights/TinkersConstruct/4722395cefb0c793d23692578ff823bc6ab458a0/"
```

6.
```bash
function makeMeta(){
cat <<EOF
{
   "pack":{
      "pack_format":3,
      "description":"A bunch of new textures for Tinker's construct, kindly provided by RCXcrafter([https://github.com/RCXcrafter]), and constructed according to instructions/script provided by StaticPH([https://github.com/StaticPH])."
   }
}
EOF
}
makeMeta > newTinkersTextures/pack.mcmeta
```

7. *Just a little cleanup*
```bash
rm assets.txt
```

8. *Remember that file you created in step 3? Well, now that you're done, you can delete it. Or not, its totally up to you.*
```bash
rm diffElem.txt
```
