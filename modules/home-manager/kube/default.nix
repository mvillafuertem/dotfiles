{ ... }: {
  # Wrapper de credenciales para el exec plugin de EKS: auto `aws sso login` al
  # caducar la sesión SSO y reintento. El ~/.kube/config (gitignored, por host)
  # apunta el `exec.command` de los contextos que lo necesiten a esta ruta.
  # Es un script estático (no contenido runtime), así que el symlink al store va bien;
  # ~/.kube/config no se toca (sigue siendo un archivo real escribible por kubectl).
  home.file.".kube/aws-eks-auth.sh" = {
    source = ./aws-eks-auth.sh;
    executable = true;
  };
}
