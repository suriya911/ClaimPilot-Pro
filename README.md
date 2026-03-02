# ClaimPilot Pro

ClaimPilot Pro is an AI-assisted medical coding workflow for clinical-note intake, ICD-10/CPT suggestion, claim review, and PDF generation.

It includes:
- `backend/`: FastAPI API
- `frontend/`: React + Vite app
- `infra/terraform/`: AWS infrastructure code

## Current Status

The project is deployed on AWS.

- Frontend: `http://claimpilot-pro-frontend-807430513014.s3-website-us-east-1.amazonaws.com`
- Backend: `http://claimpilot-pro-prod-alb-1674531874.us-east-1.elb.amazonaws.com`
- Health check: `http://claimpilot-pro-prod-alb-1674531874.us-east-1.elb.amazonaws.com/health`

## Main Flow

The Upload page is a 4-box layout:

- Top left: upload PDF or image
- Top right: extracted content preview
- Bottom left: paste clinical notes
- Bottom right: sample documents and anonymous sample notes

User flow:

1. Upload a file or paste note text
2. Click `Process Text` if using pasted text
3. Review extracted content in the preview box
4. Click `Suggest Codes`
5. Review suggestions
6. Approve codes and generate claim output

## Anonymous Sample Data

The frontend includes anonymous sample notes so reviewers can test the app without personal data.

- Google Drive sample reports folder:
  `https://drive.google.com/drive/folders/1nkFLABt97dOwNJyIqH_32O41ExNiwHD_?usp=sharing`

The sample-note cards are embedded directly in the Upload page.

## Features

- Clinical note upload from PDF/image
- Direct text paste workflow
- S3 direct upload with pre-signed URLs
- Extracted text preview before coding
- ICD-10 and CPT suggestion flow
- CMS-1500 and claim PDF generation
- AWS deployment with ALB, EC2, S3, and RDS
- Anonymous sample-note testing flow

## Repository Structure

- `backend/app/main.py`: API entrypoint
- `backend/app/llm_refine.py`: LLM and fallback suggestion logic
- `backend/app/medical_fallback.py`: deterministic local suggestion fallback
- `backend/app/storage.py`: S3 upload/presign logic
- `frontend/src/pages/Upload.tsx`: 4-box upload UI
- `frontend/src/components/SampleNotes.tsx`: sample-documents block
- `frontend/src/lib/sampleNotes.ts`: anonymous sample notes
- `infra/terraform/`: AWS infrastructure

## Local Development

### Backend

```powershell
cd d:\hackathon\ClaimPilot-Pro
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r backend\requirements.txt
uvicorn backend.app.main:app --host 0.0.0.0 --port 8000 --reload
```

### Frontend

```powershell
cd d:\hackathon\ClaimPilot-Pro\frontend
npm install
@"
VITE_API_URL=http://localhost:8000
VITE_ENABLE_S3_DIRECT_UPLOAD=false
"@ | Out-File -FilePath .env -Encoding ascii
npm run dev
```

## Environment Variables

### Backend

- `GEMINI_API_KEY`
- `GEMINI_MODEL`
- `LLM_PROVIDER`
- `LLM_DEBUG`
- `SUGGEST_MODE`
- `CORS_ORIGINS`
- `S3_UPLOAD_BUCKET`
- `S3_UPLOAD_PREFIX`
- `S3_PRESIGN_EXPIRES_SECONDS`
- `S3_KMS_KEY_ID`
- `MEDGEMMA_ENDPOINT_URL`
- `MEDGEMMA_API_KEY`
- `MEDGEMMA_MODEL`

### Frontend

- `VITE_API_URL`
- `VITE_ENABLE_S3_DIRECT_UPLOAD`
- `VITE_SAMPLE_REPORTS_URL`

## API Overview

Base URL:

- Local: `http://localhost:8000`
- AWS: `http://claimpilot-pro-prod-alb-1674531874.us-east-1.elb.amazonaws.com`

Main endpoints:

- `POST /upload`
- `POST /storage/presign-upload`
- `POST /storage/process-upload`
- `POST /suggest`
- `POST /generate_claim`
- `POST /claim_pdf`
- `POST /cms1500`
- `POST /cms1500/derive`
- `GET /config`
- `GET /health`

## AWS Deployment

Infrastructure is managed from:

- `infra/terraform/`

Current AWS stack includes:

- VPC
- public/private subnets
- Application Load Balancer
- EC2 Auto Scaling Group
- private S3 documents bucket
- RDS PostgreSQL
- IAM roles and instance profile
- CloudWatch alarm
- SNS topic

Frontend hosting:

- S3 static website bucket:
  `claimpilot-pro-frontend-807430513014`

Backend document bucket:

- `claimpilot-pro-prod-documents-807430513014`

## Docker

Build backend image:

```powershell
cd d:\hackathon\ClaimPilot-Pro
docker build -t claimpilot-backend:v1 .
```

## Notes About Suggestions

Suggestion flow currently works in this order:

1. Gemini-based suggestion path
2. Local deterministic fallback if the LLM does not return usable output

This avoids empty results during demo usage.

## Mobile Support

The Upload page has been adjusted for mobile:

- responsive sample-documents block
- smaller upload dropzone on phones
- wrapped filenames
- reduced textarea height on small screens

## Security Note

This is a demo/hackathon system. Do not use real PHI unless you harden the system for compliance first.

## License

Hackathon/demo use unless replaced with your preferred project license.
