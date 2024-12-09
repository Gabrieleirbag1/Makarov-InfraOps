import { getWebInstrumentations, initializeFaro } from '@grafana/faro-web-sdk';
import { TracingInstrumentation } from '@grafana/faro-web-tracing';

initializeFaro({
    url: 'https://faro-collector-prod-us-west-0.grafana.net/collect/07b39176d47f619861f0773f090353a2',
    app: {
        name: 'django',
        version: '1.0.0',
        environment: 'production'
    },
    instrumentations: [
        ...getWebInstrumentations(),
        new TracingInstrumentation(),
    ],m
});
