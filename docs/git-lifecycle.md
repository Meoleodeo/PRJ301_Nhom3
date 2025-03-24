-- Just for sharing Git lifecycle, hope useful for our teamwork to reduce conflicts
and good control source code next time:
(There are many ways to rebase/merge and commit, we can implement this way for fast process on develop branch directly)


> **Làm ơn, dù có gpt hay search ở đâu cũng đừng dùng lệnh nào có từ `drop` hoặc flag `-f` (force)!**

to clone:
```bash
git clone https://github.com/Meoleodeo/PRJ301_Nhom3
```
to pull:
```bash
git pull origin main
```
before push:
```bash
git checkout -b urName
git stash
```
to push:
```bash
git add .
git commit -m "ur mesg"
git push
```

### For Abslutely Feature Runned
1. Before you implement a new feature
From main branch,
```bash
git pull origin main
```
2. Implement the feature and review (done) + Stash code
```bash
git add .
git stash                     // store code in stash
```
3. Pull the latest code from main
```bash
git pull origin main
```
4. Take code from stash out and resolve conflicts (if any) + commit code
```bash
git stash pop
git commit -a -m "feat: implement abc"
```

5. Push code to main again to sync remote repository
```bash
git push origin main
```
=> Finish + and do same with other features
