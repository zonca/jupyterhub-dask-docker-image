# JupyterHub Dask Docker Image

A Docker image that combines JupyterHub, Dask, and additional scientific computing tools for scalable data analysis and distributed computing workflows.

## Overview

This Docker image is built on top of the official [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/) `scipy-notebook` image and includes:

- **Dask**: A flexible library for parallel computing in Python
- **Dask-Kubernetes**: Deploy Dask clusters on Kubernetes
- **Jupyter Server Proxy**: Proxy web services alongside Jupyter notebooks
- **Flake8**: Python linting tool for code quality
- All the scientific Python packages from the scipy-notebook base image (NumPy, Pandas, SciPy, Matplotlib, etc.)

This image is designed to work seamlessly with JupyterHub deployments, particularly in Kubernetes environments, enabling distributed computing workflows directly from Jupyter notebooks.

## Features

- 🚀 **Distributed Computing**: Run Dask computations in parallel across multiple workers
- ☸️ **Kubernetes Native**: Deploy Dask clusters on Kubernetes with dask-kubernetes
- 📊 **Scientific Stack**: Full suite of scientific computing libraries pre-installed
- 🔗 **Jupyter Server Proxy**: Access Dask dashboard and other web services through Jupyter
- 🐳 **Production Ready**: Automated builds and publishing via GitHub Actions
- 🔒 **Secure**: Built on official Jupyter base images with regular updates

## Quick Start

### Pulling the Image

The image is automatically built and published to GitHub Container Registry:

```bash
docker pull ghcr.io/zonca/jupyterhub-dask-docker-image:main
```

### Running the Container

Run the container with Jupyter Lab:

```bash
docker run -p 8888:8888 ghcr.io/zonca/jupyterhub-dask-docker-image:main
```

Then open your browser and navigate to `http://localhost:8888`. The token will be displayed in the terminal output.

### Using with JupyterHub

This image is designed to be used with JupyterHub. In your JupyterHub configuration, set:

```python
c.KubeSpawner.image = 'ghcr.io/zonca/jupyterhub-dask-docker-image:main'
```

## Using Dask

Once you're running a Jupyter notebook, you can start using Dask:

### Local Dask Cluster

```python
from dask.distributed import Client

# Create a local cluster
client = Client()

# View the Dask dashboard
client
```

### Kubernetes Dask Cluster

```python
from dask_kubernetes import KubeCluster
from dask.distributed import Client

# Create a Dask cluster on Kubernetes
cluster = KubeCluster()
cluster.scale(10)  # Scale to 10 workers

client = Client(cluster)
```

The Dask dashboard can be accessed through Jupyter Server Proxy, typically at `/proxy/8787/status`.

## Installed Packages

### Core Requirements

- **flake8**: Python code linter
- **dask**: Parallel computing library
- **dask-kubernetes**: Kubernetes integration for Dask
- **jupyter-server-proxy**: Proxy web services through Jupyter

### From Base Image (scipy-notebook)

The base image includes a comprehensive scientific Python stack:

- JupyterLab
- NumPy
- Pandas
- SciPy
- Matplotlib
- Scikit-learn
- And many more scientific computing packages

For a complete list, see the [Jupyter Docker Stacks documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook).

## Building the Image Locally

If you want to build the image yourself:

```bash
# Clone the repository
git clone https://github.com/zonca/jupyterhub-dask-docker-image.git
cd jupyterhub-dask-docker-image

# Build the image
docker build -t jupyterhub-dask:local .

# Run your local build
docker run -p 8888:8888 jupyterhub-dask:local
```

## Customization

### Adding More Packages

To add additional packages, modify the `requirements.txt` file:

```txt
flake8
dask
dask-kubernetes
jupyter-server-proxy
# Add your packages here
your-package-name
```

Then rebuild the image:

```bash
docker build -t jupyterhub-dask:custom .
```

### Using a Different Base Image

The Dockerfile uses `quay.io/jupyter/scipy-notebook:2025-11-10`. You can change this to:

- `jupyter/minimal-notebook` - Minimal Jupyter installation
- `jupyter/datascience-notebook` - Includes R and Julia
- `jupyter/tensorflow-notebook` - Includes TensorFlow

## CI/CD

This repository uses GitHub Actions to automatically:

- Build the Docker image on every push to `main`
- Publish tagged releases
- Sign images with cosign for supply chain security
- Cache layers for faster builds

Images are published to the GitHub Container Registry at `ghcr.io/zonca/jupyterhub-dask-docker-image`.

### Tagging Releases

To create a new release, push a date-based tag:

```bash
git tag 2025-11-18
git push origin 2025-11-18
```

This will trigger a build and publish the image with that tag.

## Use Cases

This image is ideal for:

- 📈 **Data Science Workflows**: Analyze large datasets with Dask and Pandas
- 🧮 **Scientific Computing**: Run parallel computations across a Kubernetes cluster
- 🎓 **Education**: Teach distributed computing concepts with Jupyter notebooks
- 🔬 **Research**: Conduct reproducible research with containerized environments
- ☁️ **Cloud Computing**: Deploy scalable notebooks in cloud Kubernetes environments

## Troubleshooting

### Dask Dashboard Not Accessible

If you can't access the Dask dashboard through Jupyter Server Proxy:

1. Ensure `jupyter-server-proxy` is installed (it should be in the image)
2. The dashboard is typically at `/proxy/8787/status`
3. Check that the Dask scheduler is running

### Permission Issues

The image runs as the `jovyan` user (UID 1000) by default. If you're mounting volumes, ensure proper permissions:

```bash
docker run -p 8888:8888 -v $(pwd)/data:/home/jovyan/data ghcr.io/zonca/jupyterhub-dask-docker-image:main
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project builds upon the [Jupyter Docker Stacks](https://github.com/jupyter/docker-stacks) which is licensed under the BSD 3-Clause License. Please refer to the original project for license details.

## Resources

- [Dask Documentation](https://docs.dask.org/)
- [Dask-Kubernetes Documentation](https://kubernetes.dask.org/)
- [Jupyter Docker Stacks Documentation](https://jupyter-docker-stacks.readthedocs.io/)
- [JupyterHub Documentation](https://jupyterhub.readthedocs.io/)
- [GitHub Container Registry](https://ghcr.io)

## Support

For issues, questions, or contributions, please use the [GitHub Issues](https://github.com/zonca/jupyterhub-dask-docker-image/issues) page.
