## Minimal Reproducable Example of runtime variable substitution with `import-meta-env` using `Vite` and `Docker`

To Reproduce:

1. Install Packages

```
npm i
```

2. Build docker image

```
docker build . -t vite-runtime-vars-docker
```

3. Run docker image

```
docker run -d -p 5173:80 --env TEST=test
```

4. Observe that variables are not available in the console.
