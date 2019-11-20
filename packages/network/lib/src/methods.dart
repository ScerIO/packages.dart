enum HttpMethod {
  head,
  delete,
  get,
  path,
  post,
  put,
}

String httpMethodString(HttpMethod method) {
  switch (method) {
    case HttpMethod.head:
      return 'HEAD';
    case HttpMethod.delete:
      return 'DELETE';
    case HttpMethod.get:
      return 'GET';
    case HttpMethod.path:
      return 'PATH';
    case HttpMethod.post:
      return 'POST';
    case HttpMethod.put:
      return 'PUT';
  }
  return null;
}
