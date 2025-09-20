# Azure Portal Setup Checklist

## ⚠️ **PERMISSION ISSUE DETECTED** - Alternative Solutions

### 🚨 Problem: 401 Error accessing App Registrations
You're getting a 401 error because your account lacks permissions to create app registrations in Azure AD. This is common in enterprise environments.

## 🔄 **ALTERNATIVE SOLUTION 1: Manual Container Registry Setup (RECOMMENDED)**

### Step 1: Configure App Service Container Settings Manually
1. Go to [Azure Portal](https://portal.azure.com) → **App Services** → **rufatdotnet20250920**
2. In the left menu, click **"Container settings"** (or "Deployment Center")
3. Set these values:
   - **Registry source**: Azure Container Registry
   - **Registry**: `rufatregistry.azurecr.io`
   - **Image and tag**: `financeapp:latest` (or specific tag)
   - **Username**: Your ACR username
   - **Password**: Your ACR password
4. Click **"Save"**

### Step 2: Use Simplified GitHub Workflow
- Use the `ci-cd-simple.yml` workflow instead
- This bypasses the need for service principal

## 🔄 **ALTERNATIVE SOLUTION 2: Contact Azure Admin**

Ask your Azure administrator to:
1. Grant you "Application Developer" role in Azure AD, OR
2. Create the service principal for you, OR  
3. Configure the App Service container settings manually

## 🔄 **ALTERNATIVE SOLUTION 3: Use Only Publish Profile**

### Simplified Approach (No Service Principal Needed):
1. Download publish profile from your App Service
2. Configure container settings manually in Azure Portal
3. Use simplified workflow that only pushes to ACR and deploys via publish profile

---

## 📋 **IMMEDIATE ACTION PLAN** (Choose One):

### 🔑 Step 1: Create App Registration
- [ ] Go to [Azure Portal](https://portal.azure.com)
- [ ] Navigate: **Azure Active Directory** → **App registrations** → **New registration**
- [ ] Name: `github-actions`
- [ ] Account types: **Accounts in this organizational directory only**
- [ ] Click **Register**
- [ ] **COPY THESE VALUES:**
  - [ ] Application (client) ID: `_____________________`
  - [ ] Directory (tenant) ID: `_____________________`

### 🔐 Step 2: Create Client Secret
- [ ] In your app registration → **Certificates & secrets**
- [ ] **New client secret**
- [ ] Description: `github-actions-secret`
- [ ] Expires: **24 months**
- [ ] Click **Add**
- [ ] **IMMEDIATELY COPY** the secret value: `_____________________`

### 🛡️ Step 3: Assign Resource Group Permissions
- [ ] Go to **Resource Groups** → **Rufatgroup**
- [ ] **Access control (IAM)** → **Add** → **Add role assignment**
- [ ] Role: **Contributor**
- [ ] Assign access to: **User, group, or service principal**
- [ ] Search and select: `github-actions`
- [ ] Click **Save**

### 🔧 Step 4: GitHub Secrets Setup
Go to your GitHub repository → Settings → Secrets and variables → Actions

Create these secrets:
- [ ] `AZURE_CREDENTIALS` - JSON format:
```json
{
  "clientId": "your-application-client-id-from-step1",
  "clientSecret": "your-client-secret-from-step2",
  "subscriptionId": "60d8cd1a-5b95-44d3-ba13-5683e6af664c",
  "tenantId": "your-tenant-id-from-step1"
}
```

- [ ] `ACR_LOGIN_SERVER`: `rufatregistry.azurecr.io`
- [ ] `ACR_USERNAME`: (your ACR username)
- [ ] `ACR_PASSWORD`: (your ACR password)
- [ ] `AZURE_WEBAPP_NAME`: `rufatdotnet20250920`
- [ ] `AZURE_RESOURCE_GROUP`: `Rufatgroup`
- [ ] `AZURE_PUBLISH_PROFILE`: (download from your App Service)

### 🚀 Step 5: Test Deployment
- [ ] Push changes to your master branch
- [ ] Check GitHub Actions workflow execution
- [ ] Verify deployment success in Azure Portal

---

## 🆘 If Something Goes Wrong

**App Registration Issues:**
- Make sure you have Azure AD permissions
- Try using a different browser or incognito mode

**Permission Issues:**
- Verify the service principal has Contributor role on the resource group
- Wait 5-10 minutes for permissions to propagate

**Deployment Issues:**
- Check all GitHub secrets are correctly set
- Verify ACR credentials are valid
- Check Azure App Service logs for detailed errors

---

## 📞 Current Values (fill in as you go):
- Subscription ID: `60d8cd1a-5b95-44d3-ba13-5683e6af664c`
- Resource Group: `Rufatgroup`
- App Service: `rufatdotnet20250920`
- ACR: `rufatregistry.azurecr.io`